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

public partial class ManageData : System.Web.UI.Page
{
    private string idTipo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       
        idTipo = Request.QueryString["idTipo"];

        if (idTipo=="0")
        {
            li_news.Attributes["class"] = "active";
        }
        else if (idTipo == "1")
        {
            li_prog.Attributes["class"] = "active";
        }
        else if (idTipo == "2")
        {
            li_form.Attributes["class"] = "active";
        }

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

            //if (dtNews.Rows[0]["Autore"].ToString() != "")
            //{
            //    imgAutore.ImageUrl = "~/Admin/images/ball_blue_16.png";
            //}
            //if (dtNews.Rows[0]["Fonte"].ToString() != "")
            //{
            //    imgFonte.ImageUrl = "~/Admin/images/ball_blue_16.png";
            //}
            //if (dtNews.Rows[0]["Allegati"].ToString() != "")
            //{
            //    lblAllegato.Text = "Si";
            //    imgAllegato.ImageUrl = "~/Admin/images/ball_blue_16.png";
            //}
            //if (PhotoManager.isNewsLinked(int.Parse(newsID)))
            //{
            //    lbllinkGall.Text = "Si";
            //    imgFotoAlbum.ImageUrl = "~/Admin/images/ball_blue_16.png";
            //}
            //if (dtNews.Rows[0]["Video"].ToString() != "")
            //{
            //    lblVideo.Text = "Si";
            //    imgVideo.ImageUrl = "~/Admin/images/ball_blue_16.png";
            //}
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
            Response.Redirect("AddModData.aspx?NewsID=" + newsID+"&idTipo="+idTipo);
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
                //tipo album = 1 perchè associato ad una news !
                albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(dtNews.Rows[0]["Titolo"].ToString(), true, idNews,1));
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
        Response.Redirect("~/Admin/AddModData.aspx?idTipo="+idTipo);
    }

    protected void gotosliderPage(object sender, EventArgs e)
    {
        DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlb = taA.GetAlbumByTipo(2);
        if (dtAlb.Rows.Count > 0)
            Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
    }


   
}
