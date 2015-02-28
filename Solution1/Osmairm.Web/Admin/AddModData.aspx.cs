using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;

public partial class AddModData : System.Web.UI.Page
{
  private string idTipo = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    var fileBrowser = new CKFinder.FileBrowser { BasePath = "../ckfinder/" };
    fileBrowser.SetupCKEditor(txtDescrizione);
    idTipo = Request.QueryString["idTipo"];
    switch (idTipo)
    {
      case "0":
        li_news.Attributes["class"] = "active";
        break;
      case "1":
        li_prog.Attributes["class"] = "active";
        break;
      case "2":
        li_form.Attributes["class"] = "active";
        break;
    }
    DivError.Visible = false;
    var taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
    // per lì'autocompletamento dei tags vado a riempire l'hdf hdfTagAutoComplete con tutti i tags disponibili nel db
    if (!IsPostBack)
    {
      var taTags = new DataSetVepAdminTableAdapters.TagsTableAdapter();
      DataTable dtAllTags = taTags.GetData();
      if (dtAllTags.Rows.Count > 0)
      {
        foreach (DataRow dr in dtAllTags.Rows)
        {
          hdfTagAutoComplete.Value += string.Format("{0},", dr["TagName"]);
        }
        //elimino l'ultimo separatore
        hdfTagAutoComplete.Value = hdfTagAutoComplete.Value.Substring(0, hdfTagAutoComplete.Value.Length - 1);
      }
    }
    idTipo = Request.QueryString["idTipo"];
    var newsId = Request.QueryString["NewsID"];
    if (newsId != null)
    {
      Session["NewsIDInserita"] = int.Parse(newsId);
      // si tratta di una modifica
      if ((txtTitoloNews.Text == "") && (txtData.Text == "") && (FCKeditor1.Text == ""))
      {
        //sto caricando una news da modificare
        DataTable dtNews = taNews.GetDataByID(int.Parse(newsId));
        /*gestione tag! by pepp*/
        News_ID.Text = newsId;
        txtTitoloNews.Text = dtNews.Rows[0]["Titolo"].ToString();
        txtData.Text = dtNews.Rows[0]["Data"].ToString();
        txtDescrizione.Text = dtNews.Rows[0]["Descrizione"].ToString();
        txtVideo.Text = dtNews.Rows[0]["Video"].ToString();
        imgFotoArticolo.ImageUrl = "~/" + dtNews.Rows[0]["UrlFotoHome"].ToString();
        var PathStdFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
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
        //Fotogallery
        if (PhotoManager.isNewsLinked(int.Parse(newsId)))
        {
          imgCancFotoG.Visible = true;
          txtFotoGallery.Text = "";
          btnFotoAlbum.Text = "Modifica";
          btnFotoAlbum.CssClass = "btn mini";
        }
        else
        {
          imgCancFotoG.Visible = false;
          txtFotoGallery.Text = "Nessuna Gallery inserita";
          btnFotoAlbum.Text = "Aggiungi";
          btnFotoAlbum.CssClass = "btn";
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
        if (idTipo == "0")
        {
          //  string newsFromTemplate = ReadTemplateFromFile("template_news.html");
          FCKeditor1.Text = dtNews.Rows[0]["Testo"].ToString();
          const string cssWithSeparator = "<link href=\"../../css/style.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" /><link href=\"../../css/blog.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" /><!--start-->";
          FCKeditor1.Text = string.Format("{0}{1}", cssWithSeparator, FCKeditor1.Text);
        }
        chkboxPrjHome.Checked = (bool.Parse(dtNews.Rows[0]["Visibile"].ToString()));
        bool flagws;
        if (!(bool.TryParse(dtNews.Rows[0]["Ws_Flag"].ToString(), out flagws)))
        {
          chkboxCitazione.Checked = false;
        }
        chkboxCitazione.Checked = flagws;
        // devo prendermi anche i path degli allegati e delle foto e salvare queste info nel var di sessione
        Session["UrlFotoHome"] = dtNews.Rows[0]["UrlFotoHome"].ToString();
        Session["UrlAllegato"] = dtNews.Rows[0]["Allegati"].ToString();
        Session["DataInserimento"] = dtNews.Rows[0]["Data"].ToString();
      }
      ButtonAgg.Visible = true;
      ButtonInsert.Visible = false;
      //trFotoGallery.Visible = true;
    }
    else
    {
      if (txtTitoloNews.Text == "") //si tratta del pageload di una nuova news
      {
        if (idTipo == "0")
        {
          FCKeditor1.Text = ReadTemplateFromFile("template_news.html");
        }
       
        var PathStdFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
        ButtonAgg.Visible = false;
        ButtonInsert.Visible = true;
        Session["UrlFotoHome"] = PathStdFotoHome.Remove(0, 2);
        imgFotoArticolo.ImageUrl = PathStdFotoHome;
        previewFoto.HRef = PathStdFotoHome;
        lnkCancFoto.Visible = false;
        imgFotoArticolo.Visible = false;
        FileUploadFoto.Visible = true;
        ButtonUploadFoto.Visible = true;
        lnkCancAllegato.Visible = false;
      }
    }
  }

  static string ReadTemplateFromFile(string templateType)
  {
    var fileName = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + templateType);
    if (!File.Exists(fileName))return string.Empty;
    using (StreamReader stFile = File.OpenText(fileName))
    {
     return stFile.ReadToEnd();
    }
  }

  protected void btnUploadAllegati_Click(object sender, EventArgs e)
  {
    var pathAllegatoFromConfig = Utility.SearchConfigValue("pathAllegatiNews");
    var filePath = Server.MapPath(pathAllegatoFromConfig.Replace("/", "\\"));
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
      previewFoto.HRef = PathStdFotoHome;
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

  protected void btnInsert_Click(object sender, EventArgs e)
  {
    var urlFotoHome = (string)Session["UrlFotoHome"];
    var allegati = (string)Session["UrlAllegato"];
    
    if (urlFotoHome == "")
    {
      urlFotoHome = Utility.SearchConfigValue("pathFotoNews") + Utility.SearchConfigValue("standardFotoName");
    }
    var taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
    if (idTipo == "0")
    {
      string[] separator = { "<!--start-->" };
      string[] splitted = FCKeditor1.Text.Split(separator, StringSplitOptions.None);
      if (splitted.Length > 1)
      { FCKeditor1.Text = splitted[1]; }
    }
    txtVideo.Text = Utility.NormalizeYouTubeVideoEmbeddedHtml(txtVideo.Text);
    int idNews = Convert.ToInt32(taNews.InsertQuery(
        "_fonte",
        txtTitoloNews.Text,
        FCKeditor1.Text,
        System.Convert.ToDateTime(txtData.Text),
        chkboxPrjHome.Checked,
        txtDescrizione.Text,
        idTipo,
        urlFotoHome,
        allegati,
        txtVideo.Text.Replace("?", "?wmode=transparent&amp;"),
        "",//TextBoxTitoloENG.Text,
        "_dummy_autoreENG",//autore inglese
        "",//TextBoxDescrizioneENG.Text,
        "",////FCKeditor2.Value,
        "",//TextBoxTitoloTED.Text,
        "",//TextBoxDescrizioneTED.Text,
        "",//testotTED
        txtTags.Value,
        chkboxCitazione.Checked
        ));
    /*devo aggiornare il dizionario dei tags*/
    DataSetVepAdminTableAdapters.TagsTableAdapter taTags = new DataSetVepAdminTableAdapters.TagsTableAdapter();
    string[] _tagsEntry = txtTags.Value.Split(',');
    for (int i = 0; i < _tagsEntry.Length; i++)
    {
      DataTable dtTaginDictionary = taTags.GetDataByTagName(_tagsEntry[i]);
      if (dtTaginDictionary.Rows.Count == 0)
        taTags.InsertQuery(_tagsEntry[i]);
    }
    Session["NewsIDInserita"] = idNews;
    Session["CaptionAlbumNews"] = txtTitoloNews.Text;
    News_ID.Text = idNews.ToString();
    Response.Redirect("~/Admin/ManageData.aspx?idTipo=" + idTipo);
 
  }

  protected void btnUpdate_Click(object sender, EventArgs e)
  {
    int idNews = (int)Session["NewsIDInserita"];
    DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
    string allegati = (string)Session["UrlAllegato"];
    string urlFotoHome = (string)Session["UrlFotoHome"];
    string data = (string)Session["DataInserimento"];
    txtVideo.Text = Utility.NormalizeYouTubeVideoEmbeddedHtml(txtVideo.Text);
    if (idTipo == "0")
    {
      string[] separator = { "<!--start-->" };
      string[] splitted = FCKeditor1.Text.Split(separator, StringSplitOptions.None);
      if (splitted.Length > 1)
        FCKeditor1.Text = splitted[1];
    }
    try
    {
      News_ID.Text = idNews.ToString();
      taNews.UpdateQuery(
          "_fonte",
          txtTitoloNews.Text,
          FCKeditor1.Text,
          System.Convert.ToDateTime(txtData.Text),
          chkboxPrjHome.Checked,
          txtDescrizione.Text,
          idTipo,
          urlFotoHome,
          allegati,
          txtVideo.Text,
          "",//TextBoxTitoloENG.Text,
          "-",
          "",//TextBoxDescrizioneENG.Text,
          "",////FCKeditor2.Value,
          "",//TextBoxTitoloTED.Text,
          "",//TextBoxDescrizioneTED.Text,
          "",//FCKeditor3.Value,
          txtTags.Value,
          chkboxCitazione.Checked,
          int.Parse(News_ID.Text));
      /*devo aggiornare il dizionario dei tags*/
      DataSetVepAdminTableAdapters.TagsTableAdapter taTags = new DataSetVepAdminTableAdapters.TagsTableAdapter();
      string[] _tagsEntry = txtTags.Value.Split(',');
      for (int i = 0; i < _tagsEntry.Length; i++)
      {
        DataTable dtTaginDictionary = taTags.GetDataByTagName(_tagsEntry[i]);
        if (dtTaginDictionary.Rows.Count == 0)
          taTags.InsertQuery(_tagsEntry[i]);
      }
      DivSuccess.Visible = true;
      DivError.Visible = false;
      Response.Redirect("~/Admin/ManageData.aspx?idTipo=" + idTipo);
    }
    catch (Exception ex)
    {
      LabelError.Text = ex.Message;
      DivSuccess.Visible = false;
      DivError.Visible = true;
    }
  }

  protected void btnUploadFoto_Click(object sender, EventArgs e)
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
          previewFoto.HRef = "../img/foto/" + FileUploadFoto.FileName;
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

  protected void btnAnnulla_Click(object sender, EventArgs e)
  {
    Response.Redirect("~/Admin/ManageData.aspx?idTipo=" + idTipo);
  }

  protected void btnGalleryArt_Click(object sender, EventArgs e)
  {
    if (!String.IsNullOrEmpty(Request.QueryString["NewsID"]))
    {
      int idNews = int.Parse(Request.QueryString["NewsID"]);
      string caption = (string)Session["CaptionAlbumNews"];
      DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
      int albumID = 0;
      if (Request.QueryString["NewsID"] == null)
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
        Session["NewsIDInserita"] = int.Parse(Request.QueryString["NewsID"]);
        Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
      }
    }
    else
    {
      //errore devi prima inserire la news e poi puoi associare la fotogallery
      LabelError.Text = "Errore:devi prima salvare la news e dopo puoi associare una gallery";
      DivError.Visible = true;
      DivSuccess.Visible = false;
    }
  }

  protected void gotoSpecial(object sender, EventArgs e)
  {
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(3);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }

  protected void gotosliderPage(object sender, EventArgs e)
  {
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(2);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }

  protected void CancellaFotoGallery(object sender, EventArgs e)
  {
    string idNews = Request.QueryString["NewsID"];
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
      imgCancFotoG.Visible = false;
      txtFotoGallery.Text = "Nessuna Gallery";
      btnFotoAlbum.Text = "Aggiungi";
      btnFotoAlbum.CssClass = "btn";
    }
    else
    {
      //messaggio notifica 
    }
  }
}