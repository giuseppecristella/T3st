﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using AjaxControlToolkit;
public partial class AddModPersonale : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    ddlTipo.Enabled = false;
    DivError.Visible = false;
    string idNews = Request.QueryString["ID"];
    if (idNews != null)
    {
      Session["NewsIDInserita"] = int.Parse(idNews);
      // si tratta di una modifica
      if ((txtTitoloNews.Text == ""))
      {
        //sto caricando una news da modificare
        DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
        DataTable dtNews = taNews.GetDataByID(int.Parse(idNews));
        News_ID.Text = idNews;
        txtTitoloNews.Text = dtNews.Rows[0]["Titolo"].ToString();
        //txtAutore.Text = dtNews.Rows[0]["Autore"].ToString();
        txtwebsite.Text = dtNews.Rows[0]["Fonte"].ToString();
        txtDescrizione.Text = dtNews.Rows[0]["Descrizione"].ToString();
        //    TextBoxTitoloENG.Text = dtNews.Rows[0]["TitoloENG"].ToString();
        //   TextBoxDescrizioneENG.Text = dtNews.Rows[0]["DescrizioneENG"].ToString();
        //FCKeditor2.Value = dtNews.Rows[0]["TestoENG"].ToString();
        txtData.Text = dtNews.Rows[0]["Data"].ToString();
        //     TextBoxTitoloTED.Text = dtNews.Rows[0]["TitoloTED"].ToString();
        //     TextBoxDescrizioneTED.Text = dtNews.Rows[0]["DescrizioneTED"].ToString();
        //txtVideo.Text = dtNews.Rows[0]["Video"].ToString();
        imgFotoArticolo.ImageUrl = "~/" + dtNews.Rows[0]["UrlFotoHome"].ToString();
        /*peppola*/
        string PathStdFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
        if ((imgFotoArticolo.ImageUrl != "") && (imgFotoArticolo.ImageUrl != "~/") && (imgFotoArticolo.ImageUrl != PathStdFotoHome))
        {
          lnkCancFoto.Visible = true;
          imgFotoArticolo.Visible = true;
          FileUploadFoto.Visible = false;
          ButtonUploadFoto.Visible = false;
        }
        else
        {
          imgFotoArticolo.Visible = false;
          FileUploadFoto.Visible = true;
          ButtonUploadFoto.Visible = true;
        }
        lblpathFileAll.Text = dtNews.Rows[0]["Allegati"].ToString().Replace("public/allegati/", "");
        if ((lblpathFileAll.Text != "Nessun file allegato") && (lblpathFileAll.Text != ""))
        {
          lnkCancAllegato.Visible = true;
          FileUploadAllegati.Visible = false;
          ButtonUploadAllegati.Visible = false;
        }
        else
        {
          lblpathFileAll.Text = "Nessun file allegato";
          lnkCancAllegato.Visible = false;
          FileUploadAllegati.Visible = true;
          ButtonUploadAllegati.Visible = true;
        }
        TextBoxTelefono.Text = dtNews.Rows[0]["Testo"].ToString();
        //uso il campo autore per ved. se visualizzare la news in homepage
        // devo prendermi anche i path degli allegati e delle foto e salvare queste info nel var di sessione
        Session["UrlFotoHome"] = dtNews.Rows[0]["UrlFotoHome"].ToString();
        Session["UrlAllegato"] = dtNews.Rows[0]["Allegati"].ToString();
        Session["DataInserimento"] = dtNews.Rows[0]["Data"].ToString();
      }
      ddlTipo.SelectedValue = (string)Session["ddlTipo"];
      ButtonAgg.Visible = true;
      ButtonInsert.Visible = false;
    }
    else
    {
      if (txtTitoloNews.Text == "") //si tratta del pageload di una nuova news
      {
        ddlTipo.SelectedValue = (string)Session["ddlTipo"];
        string allegati = (string)Session["UrlAllegato"];
        string PathStdFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
        ButtonAgg.Visible = false;
        ButtonInsert.Visible = true;
        Session["UrlFotoHome"] = PathStdFotoHome.Remove(0, 2);
        imgFotoArticolo.ImageUrl = PathStdFotoHome;
        // previewFoto.HRef = PathStdFotoHome;
        lnkCancFoto.Visible = false;
        imgFotoArticolo.Visible = false;
        FileUploadFoto.Visible = true;
        ButtonUploadFoto.Visible = true;
        lnkCancAllegato.Visible = false;
      }
    }
  }
  protected void gotoSpecial(object sender, EventArgs e)
  {
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(3);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }
  //Pulsante di INSERIMENTO della News
  protected void ButtonInsert_Click(object sender, EventArgs e)
  {
    string urlFotoHome = (string)Session["UrlFotoHome"];
    string allegati = (string)Session["UrlAllegato"];
    try
    {
      if (urlFotoHome == "")
      {
        urlFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
      }
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
      int idNews = Convert.ToInt32(taNews.InsertQuery(
          txtwebsite.Text,
          txtTitoloNews.Text,
          TextBoxTelefono.Text,
          System.Convert.ToDateTime(txtData.Text),
          false,
          txtDescrizione.Text, //email
           ddlTipo.SelectedItem.Value,
          urlFotoHome,
          allegati,
          "",//txtVideo.Text,
          "_dummy_titoloENG",
          "_dummy_autoreENG",//autore inglese
          "_dummy_descENG",
          "",//FCKeditor2.Value,
          "_dummy_titoloDE",
          "_dummy_descIT",
         "",// FCKeditor3.Value,
          "_dummy_tags",
          false
          ));
      Session["NewsIDInserita"] = idNews;
      Session["CaptionAlbumNews"] = txtTitoloNews.Text;
      News_ID.Text = idNews.ToString();
      Session["ddlTipo"] = ddlTipo.SelectedValue;
      ddlTipo.Enabled = false;
      Response.Redirect("~/Admin/ManagePersonale.aspx");
    }
    catch (Exception ex)
    {
      DivSuccess.Visible = false;
      DivError.Visible = true;
    }
  }
  //Pulsante di AGGIORNAMENTO della News
  protected void ButtonAgg_Click(object sender, EventArgs e)
  {
    int idNews = (int)Session["NewsIDInserita"];
    DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
    string allegati = (string)Session["UrlAllegato"];
    string urlFotoHome = (string)Session["UrlFotoHome"];
    string data = (string)Session["DataInserimento"];
    try
    {
      News_ID.Text = idNews.ToString();
      taNews.UpdateQuery(
          txtwebsite.Text,
          txtTitoloNews.Text,
          TextBoxTelefono.Text,
           System.Convert.ToDateTime(txtData.Text),
         false,
          txtDescrizione.Text,
           ddlTipo.SelectedItem.Value,
          urlFotoHome,
          allegati,
          "",//txtVideo.Text,      
          "",
          "-",
          "",
          "",//FCKeditor2.Value,
          "",
          "",
          "",//FCKeditor3.Value,
          "_duumy_tags",
           false,
          int.Parse(News_ID.Text));
      DivSuccess.Visible = true;
      DivError.Visible = false;
      Response.Redirect("~/Admin/ManagePersonale.aspx");
    }
    catch (Exception ex)
    {
      LabelError.Text = ex.Message;
      DivSuccess.Visible = false;
      DivError.Visible = true;
    }
  }
  protected void CancellaAllegato(object sender, EventArgs e)
  {
    string pathAllegatoFromConfig = Utility.SearchConfigValue("pathAllegatiNews");
    string pathAllegato = Server.MapPath(pathAllegatoFromConfig.Replace("/", "\\"));
    string nomeFile = lblpathFileAll.Text.Replace(pathAllegatoFromConfig.Remove(0, 2), "");
    try
    {
      File.Delete(pathAllegato + nomeFile);
      Session["UrlAllegato"] = "";
      lblpathFileAll.Text = "Nessun file allegato";
      lnkCancAllegato.Visible = false;
      FileUploadAllegati.Visible = true;
      ButtonUploadAllegati.Visible = true;
    }
    catch (Exception ex)
    {
      DivError.Visible = true;
      DivSuccess.Visible = false;
      LabelError.Text = ex.Message;
    }
  }
  protected void ButtonUploadAllegati_Click(object sender, EventArgs e)
  {
    string pathAllegatoFromConfig = Utility.SearchConfigValue("pathAllegatiNews");
    string filePath = Server.MapPath(pathAllegatoFromConfig.Replace("/", "\\"));
    //string filePath = Server.MapPath("~\\public\\allegati\\");
    if (FileUploadAllegati.HasFile)
    {
      // se si, aggiorniamo il path del file
      filePath += FileUploadAllegati.FileName;
      // salviamo il file nel percorso calcolato
      FileUploadAllegati.SaveAs(filePath);
      Session["UrlAllegato"] = pathAllegatoFromConfig.Remove(0, 2) + FileUploadAllegati.FileName;
      lblpathFileAll.Text = ((string)Session["UrlAllegato"]).Replace("public/allegati/", "");
      lnkCancAllegato.Visible = true;
      FileUploadAllegati.Visible = false;
      ButtonUploadAllegati.Visible = false;
    }
    else
    {
      DivSuccess.Visible = false;
      DivError.Visible = true;
      LabelError.Text = "Warning: click \"browse files\".";
    }
  }
  protected void ButtonUploadFoto_Click(object sender, EventArgs e)
  {
    string pathFotoFromConfig = Utility.SearchConfigValue("pathFotoNews");
    string fileName = Server.HtmlEncode(FileUploadFoto.FileName);
    string filePath = Server.MapPath(pathFotoFromConfig.Replace("/", "\\"));
    string extension = System.IO.Path.GetExtension(fileName);
    //string filePath = Server.MapPath("~\\img\\FotoArticoli\\");
    // controlliamo se il controllo FileUploadFoto contiene un file da caricare
    if (FileUploadFoto.HasFile)
    {
      if ((extension.ToUpper() == ".JPG") || (extension.ToUpper() == ".PNG"))
      {
        int fileSize = FileUploadFoto.PostedFile.ContentLength;
        // consento l'upload di file con dimensione < di 1mb!
        if (fileSize < 1100000)
        {
          // se si, aggiorniamo il path del file
          filePath += FileUploadFoto.FileName;
          // salviamo il file nel percorso calcolato
          FileUploadFoto.SaveAs(filePath);
          Session["UrlFotoHome"] = pathFotoFromConfig.Remove(0, 2) + FileUploadFoto.FileName;
          imgFotoArticolo.ImageUrl = pathFotoFromConfig + FileUploadFoto.FileName;
          lnkCancFoto.Visible = true;
          imgFotoArticolo.Visible = true;
          FileUploadFoto.Visible = false;
          ButtonUploadFoto.Visible = false;
          // previewFoto.HRef = "../img/foto/" + FileUploadFoto.FileName;
        }
        else
        {
          LabelError.Text = "Error: max file size (1Mb).";
          DivSuccess.Visible = false;
          DivError.Visible = true;
        }
      }
      else
      {
        DivSuccess.Visible = false;
        DivError.Visible = true;
        LabelError.Text = "Error: no correct file format (accepted: jpg|png)";
      }
    }
    else
    {
      DivSuccess.Visible = false;
      DivError.Visible = true;
      LabelError.Text = "Warning: click \"browse files\".";
    }
  }
  protected void ButtonAnnulla_Click(object sender, EventArgs e)
  {
    Response.Redirect("~/Admin/ManagePersonale.aspx");
  }
  protected void BtnGalleryArt_Click(object sender, EventArgs e)
  {
    int idNews = int.Parse(Request.QueryString["ID"]);
    if (idNews != 0)
    {
      string caption = (string)Session["CaptionAlbumNews"];
      DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
      int albumID = 0;
      if (Request.QueryString["ID"] == null)
      {
        albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(caption, true, idNews, 1));
        //nuova news inserita faccio una redirect e nella sessione ho già l'id_news!
        Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
      }
      else
      {
        DataTable dtAlbum = taAlbums.GetIdAlbum(idNews);
        if (dtAlbum.Rows.Count == 0)
        {
          albumID = System.Convert.ToInt32(taAlbums.InsertAlbumRetID(txtTitoloNews.Text, true, idNews, 1));
          DataTable dtIdAl = taAlbums.GetIdAlbum(idNews);
          albumID = int.Parse(dtIdAl.Rows[0]["AlbumID"].ToString());
        }
        else
        {
          albumID = int.Parse(dtAlbum.Rows[0]["AlbumID"].ToString());
        }
        //si tratta di una modifica l'id_news la ottengo dalla querystring, quindi setto la var di sessione
        Session["NewsIDInserita"] = int.Parse(Request.QueryString["ID"]);
        Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
      }
    }
    else
    {
      //errore devi prima inserire la news e poi puoi associare la fotogallery
      LabelError.Text = "Warning: news not saved.";
      DivError.Visible = true;
      DivSuccess.Visible = false;
    }
  }
  protected void CancellaFotoGallery(object sender, ImageClickEventArgs e)
  {
    string idNews = Request.QueryString["ID"];
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbum = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlbID = taAlbum.GetIdAlbum(int.Parse(idNews));
    if (dtAlbID.Rows.Count > 0)
    {
      string albumID = dtAlbID.Rows[0]["AlbumID"].ToString();
      List<Photo> list = new List<Photo>();
      list = PhotoManager.GetPhotos(int.Parse(albumID));
      for (int i = 0; i < list.Count; i++)
      {
        PhotoManager.RemovePhoto(list[i].AlbumID);
      }
      taAlbum.Delete1(int.Parse(albumID));
    }
    else
    {
      //messaggio notifica 
    }
  }
  protected void CancellaFoto(object sender, EventArgs e)
  {
    // ~/img/FotoArticoli/
    string pathFotoFromConfig = Utility.SearchConfigValue("pathFotoNews");
    string pathFoto = Server.MapPath(pathFotoFromConfig.Replace("/", "\\"));
    string nomeFile = imgFotoArticolo.ImageUrl.Replace("~/" + pathFotoFromConfig.Remove(0, 2), "");
    string PathStdFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
    try
    {
      File.Delete(pathFoto + nomeFile);
      Session["UrlFotoHome"] = PathStdFotoHome.Remove(0, 2);
      imgFotoArticolo.ImageUrl = PathStdFotoHome;
      //previewFoto.HRef = PathStdFotoHome;
      lnkCancFoto.Visible = false;
      imgFotoArticolo.Visible = false;
      FileUploadFoto.Visible = true;
      ButtonUploadFoto.Visible = true;
    }
    catch (Exception ex)
    {
      DivError.Visible = true;
      DivSuccess.Visible = false;
      LabelError.Text = ex.Message;
    }
  }
  protected void Button1_Click(object sender, EventArgs e)
  {
    int idNews = int.Parse(Request.QueryString["ID"]);
    if (idNews != 0)
    {
      string caption = (string)Session["CaptionAlbumNews"];
      DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
      int albumID = 0;
      if (Request.QueryString["ID"] == null)
      {
        albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(caption, true, idNews, 1));
        //nuova news inserita faccio una redirect e nella sessione ho già l'id_news!
        //   Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
      }
      else
      {
        DataTable dtAlbum = taAlbums.GetIdAlbum(idNews);
        if (dtAlbum.Rows.Count == 0)
        {
          albumID = System.Convert.ToInt32(taAlbums.InsertAlbumRetID(txtTitoloNews.Text, true, idNews, 1));
        }
        else
        {
          albumID = int.Parse(dtAlbum.Rows[0]["AlbumID"].ToString());
        }
        //si tratta di una modifica l'id_news la ottengo dalla querystring, quindi setto la var di sessione
        Session["NewsIDInserita"] = int.Parse(Request.QueryString["ID"]);
        //   Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
      }
    }
    else
    {
      //errore devi prima inserire la news e poi puoi associare la fotogallery
      LabelError.Text = "Warning: news not saved.";
      DivError.Visible = true;
      DivSuccess.Visible = false;
    }
  }
  protected void gotosliderPage(object sender, EventArgs e)
  {
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(2);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }
}