using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

public partial class ManagePersonale : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
  }

  protected void gotoSpecial(object sender, EventArgs e)
  {
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(3);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }

  protected void _OnCreated(object sender, ListViewItemEventArgs e)
  {
    if (e.Item.ItemType.ToString() != "EmptyItem")
    {
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
      ListViewDataItem dataItem = (ListViewDataItem)e.Item;
      string newsID = ListViewNews.DataKeys[dataItem.DisplayIndex].Value.ToString();
      DataTable dtNews = taNews.GetDataByID(int.Parse(newsID));
      Label lblAllegato = (Label)(e.Item.FindControl("lblAllAss"));
      Label lbllinkGall = (Label)(e.Item.FindControl("lbllinkGall"));
      Label lblVideo = (Label)(e.Item.FindControl("lblVideoAss"));
      Image imgAutore = (Image)(e.Item.FindControl("imgBallAutore"));
      Image imgFonte = (Image)(e.Item.FindControl("imgBallFonte"));
      Image imgAllegato = (Image)(e.Item.FindControl("imgBallAllegato"));
      Image imgFotoAlbum = (Image)(e.Item.FindControl("imgBallFotoAlbum"));
      Image imgVideo = (Image)(e.Item.FindControl("imgBallVideo"));
      Label lblRiga = (Label)(e.Item.FindControl("lblRiga"));
      lblRiga.Text = (dataItem.DataItemIndex + 1).ToString();
    }
  }

  protected void _OnItemCommand(object sender, ListViewCommandEventArgs e)
  {
    ListViewDataItem dataItem = (ListViewDataItem)e.Item;
    string newsID = ListViewNews.DataKeys[dataItem.DisplayIndex].Value.ToString();

    if (e.CommandName == "cancella")
    {
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
      taNews.Delete(int.Parse(newsID));
    }
    else if (e.CommandName == "modifica")
    {
      Session["ddlTipo"] = ddlTipo.SelectedValue;
      Response.Redirect("AddModPersonale.aspx?ID=" + newsID);
    }
    else if (e.CommandName == "fotoGallery")
    {
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
      int idNews = int.Parse(newsID);
      DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
      int albumID = 0;
      DataTable dtAlbum = taAlbums.GetIdAlbum(idNews);
      DataTable dtNews = taNews.GetDataByID(idNews);
      if (dtAlbum.Rows.Count == 0)
      {
        albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(dtNews.Rows[0]["Descrizione"].ToString(), true, idNews, 1));
        //nuova news inserita faccio una redirect e nella sessione ho già l'id_news!
        Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
      }
      else
      {
        Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + dtAlbum.Rows[0]["AlbumID"].ToString());
      }
    }

    ListViewNews.DataBind();
  }

  protected void Nuovo_Click(object sender, EventArgs e)
  {
    //Session[]=ddl 
    Session["ddlTipo"] = ddlTipo.SelectedValue;
    Response.Redirect("~/Admin/AddModPersonale.aspx");
  }

  protected void gotosliderPage(object sender, EventArgs e)
  {
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(2);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }

  protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
  {
    Session["ddlTipo"] = ddlTipo.SelectedValue;
  }
}
