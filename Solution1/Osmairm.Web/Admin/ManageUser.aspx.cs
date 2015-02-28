using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
public partial class Admin_ManageUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void _OnCreated(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType.ToString() != "EmptyItem")
        {
            DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            string utente = lvUtenti.DataKeys[dataItem.DisplayIndex].Value.ToString();
            if (Roles.IsUserInRole(utente, "Administrator"))
            {
                Panel pnlUtente = (Panel)(e.Item.FindControl("pnlUtente"));
                pnlUtente.Visible = false;
            }
            else
            {
                MembershipUser o = Membership.GetUser(utente);
                string id = o.ProviderUserKey.ToString();
                string UsrPassword = o.GetPassword();
                Label lblUserId = (Label)(e.Item.FindControl("lblUserId"));
                lblUserId.Text = id;
                Label lblPassword = (Label)(e.Item.FindControl("lblPassword"));
                lblPassword.Text = UsrPassword;
                ProfileCommon profile = Profile.GetProfile(utente);
                int albumId = profile.UserAlbumID;
                if (albumId != 0)
                {
                    Label lblFotoCount = (Label)(e.Item.FindControl("lblFotoCount"));
                    lblFotoCount.Text = (PhotoManager.GetFotoCount(albumId)).ToString();
                }
                else
                {
                    Label lblFotoCount = (Label)(e.Item.FindControl("lblFotoCount"));
                    lblFotoCount.Text = "Album non presente";
                }
                int loginCount = profile.LoginsCount;
                Label lblAccessi = (Label)(e.Item.FindControl("lblAccessi"));
                lblAccessi.Text = loginCount.ToString();
            }
        }
    }
    protected void _OnCreatedAdmin(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType.ToString() != "EmptyItem")
        {
            DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            string utente = lvUtenti.DataKeys[dataItem.DisplayIndex].Value.ToString();
            HtmlTableRow pnlAdmin = (HtmlTableRow)(e.Item.FindControl("pnlAdmin"));
            if (Roles.IsUserInRole(utente, "Administrator"))
            {
                pnlAdmin.Visible = true;
            }
            else
            {
                pnlAdmin.Visible = false;
            }
        }
    }
    protected void _OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        ListViewDataItem dataItem = (ListViewDataItem)e.Item;
        string utente = lvUtenti.DataKeys[dataItem.DisplayIndex].Value.ToString();
        ProfileCommon profile = Profile.GetProfile(utente);
        int albumId = profile.UserAlbumID;
        if (e.CommandName == "modifica")
        {
            Response.Redirect("Photos.aspx?AlbumID=" + albumId);
        }
        else if (e.CommandName == "cancella")
        {
            Membership.DeleteUser(utente, true);
            lvUtenti.DataBind();
        }
    }
    protected void Nuovo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/CreaUtente.aspx");
    }
    protected void Nuovo_Admin_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/CreaAdmin.aspx");
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
    protected void _OnItemCommandAdmin(object sender, ListViewCommandEventArgs e)
    {
        ListViewDataItem dataItem = (ListViewDataItem)e.Item;
        string utente = ListViewAdmin.DataKeys[dataItem.DisplayIndex].Value.ToString();
        if (e.CommandName == "cancella")
        {
            Membership.DeleteUser(utente, true);
            ListViewAdmin.DataBind();
        }
    }
}
