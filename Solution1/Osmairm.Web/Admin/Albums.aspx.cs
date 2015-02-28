using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
public partial class Admin_Albums_aspx : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            /*modifica per filtro tipo album*/
            ddlTipoAlbum.DataBind();
            if (!string.IsNullOrEmpty((string)Session["ddlTipoAlbum"]))
            {
                ddlTipoAlbum.SelectedValue = (string)Session["ddlTipoAlbum"];
            }
            else
            {
                Session["ddlTipoAlbum"] = ddlTipoAlbum.SelectedValue;
            }
            DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
            // per lì'autocompletamento dei tags vado a riempire l'hdf con tutti i tags disponibili nel db
            //hdfTagAutoComplete
            if (!IsPostBack)
            {
                DataSetVepAdminTableAdapters.TagsTableAdapter taTags = new DataSetVepAdminTableAdapters.TagsTableAdapter();
                DataTable dtAllTags = taTags.GetData();
                if (dtAllTags.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtAllTags.Rows)
                    {
                        hdfTagAutoComplete.Value += dr["TagName"].ToString() + ",";
                    }
                    //elimino l'ultimo separatore
                    hdfTagAutoComplete.Value = hdfTagAutoComplete.Value.Substring(0, hdfTagAutoComplete.Value.Length - 1);
                }
            }
        }
    }
    protected void ddlAlbum_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["ddlTipoAlbum"] = ddlTipoAlbum.SelectedValue;
       //// cphAdminBody
        //UpdatePanel updlvAlb = (UpdatePanel)cphAdminBody.FindControl("updlvAlb");
        //if (updlvAlb != null)
        //{
            //  ListView lvAlbums = (ListView)cphAdminBody.FindControl("lvAlbums");
            //lvAlbums.DataBind();
           // updlvAlb.Update();
        //}
    }
    protected void _OnCreated(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType.ToString() != "EmptyItem")
        {
            DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            string albumID = lvAlbums.DataKeys[dataItem.DisplayIndex].Value.ToString();
            DataTable dtAlbums = taAlbums.GetInfoAlbumbyID(int.Parse(albumID));
            Label lblLinked = (Label)(e.Item.FindControl("lblLinkedtoNews"));
            //Image imgCount = (Image)(e.Item.FindControl("imgCount"));
            Image imgLinked = (Image)(e.Item.FindControl("imgLinked"));
            if (PhotoManager.GetFotoCount(int.Parse(albumID)) > 0)
            {
                //imgCount.ImageUrl = "~/Admin/images/ball_blue_16.png";
            }
            //HtmlAnchor aApriEditModal = (HtmlAnchor)
            //e.Item.FindControl("aApriEditModal");
            //HtmlGenericControl myModal = (HtmlGenericControl)
            //e.Item.FindControl("myModal");
            //aApriEditModal.HRef = "#" + myModal.ClientID;
            //if (dtAlbums.Rows[0]["NewsEventoID"].ToString() != "")
            //{
            //    lblLinked.Text = "Si";
            //    imgLinked.ImageUrl = "~/Admin/images/ball_blue_16.png";
            //}
        }
    }
    protected void gotoSpecial(object sender, EventArgs e)
    {
        DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlb = taA.GetAlbumByTipo(3);
        if (dtAlb.Rows.Count > 0)
            Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
    }
    protected void _OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        ListViewDataItem dataItem = (ListViewDataItem)e.Item;
        string albumID = lvAlbums.DataKeys[dataItem.DisplayIndex].Value.ToString();
        if (e.CommandName == "cancella")
        {
            DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbum = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
            List<Photo> list = new List<Photo>();
            list = PhotoManager.GetPhotos(int.Parse(albumID));
            for (int i = 0; i < list.Count; i++)
            {
                PhotoManager.RemovePhoto(list[i].AlbumID);
            }
            taAlbum.Delete1(int.Parse(albumID));
        }
        else if (e.CommandName == "modifica")
        {
            Response.Redirect("Photos.aspx?AlbumID=" + albumID);
        }
        else if (e.CommandName == "rinomina")
        {
            Literal ltlCaptionOK = (Literal)(e.Item.FindControl("ltlCaptionOK"));
            TextBox txtCaptionMod = (TextBox)(e.Item.FindControl("txtCaptionMod"));
            Button btnOK = (Button)(e.Item.FindControl("btnOK"));
            ltlCaptionOK.Visible = false;
            txtCaptionMod.Visible = true;
            btnOK.Visible = true;   
        }
        else if (e.CommandName == "caricaPopUp")
        {
        }
        else if (e.CommandName == "modifica_titolo")
        {
            TextBox txtTitoloAlb = (TextBox)(e.Item.FindControl("txtTitoloAlb"));
            TextBox txtDescrizioneBreve = (TextBox)(e.Item.FindControl("txtDescrizioneBreve"));
              //TextBox txtTitoloAlbDE = (TextBox)(e.Item.FindControl("txtTitoloAlbDE"));
          TextBox txtDataAlbum = (TextBox)(e.Item.FindControl("txtDataAlbum"));
            TextBox txtTags2 = (TextBox)(e.Item.FindControl("txtTags2"));
            DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlb = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
            DataTable dtAlbum = taAlb.GetInfoAlbumbyID(int.Parse(albumID));
            int idNews = int.Parse(dtAlbum.Rows[0]["NewsEventoID"].ToString());
            DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
            /*aggiorno anche i tags!*/
            taNews.UpdateCaptionAlbum(txtTitoloAlb.Text, txtDescrizioneBreve.Text, "", System.Convert.ToDateTime(txtDataAlbum.Text), txtTags2.Text, idNews);
            /*devo aggiornare il dizionario dei tags*/
            DataSetVepAdminTableAdapters.TagsTableAdapter taTags = new DataSetVepAdminTableAdapters.TagsTableAdapter();
            string[] _tagsEntry = txtTags2.Text.Split(',');
            for (int i = 0; i < _tagsEntry.Length; i++)
            {
                DataTable dtTaginDictionary = taTags.GetDataByTagName(_tagsEntry[i]);
                if (dtTaginDictionary.Rows.Count == 0)
                    taTags.InsertQuery(_tagsEntry[i]);
            }
            //taNews.UpdateOK("",txtTitoloAlb.Text,"",System.DateTime.Now,false,"","2","","","",txtTitoloAlbEN.Text,"","","",txtTitoloAlbDE.Text,"","", 
            //Aggiorna Caption by Id
        }
      // lvAlbums.DataBind();
        Response.Redirect("Albums.aspx");
    }
    protected void NewButton_Click(object sender, EventArgs e)
    {
    }
    protected void gotosliderPage(object sender, EventArgs e)
    {
        DataSetVepAdminTableAdapters.AlbumsTableAdapter taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlb = taA.GetAlbumByTipo(2);
        if (dtAlb.Rows.Count > 0)
            Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
    }
}