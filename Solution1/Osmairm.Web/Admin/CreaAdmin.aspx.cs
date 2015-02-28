using System;
using System.Web.Security;

public partial class Admin_CreaAdmin : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }

  protected void CreatedUserRedirect(object sender, EventArgs e)
  {
    var utente = CreateUserWizard1.UserName;
    var taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();

    var albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(utente, true, null, 4));
    var profile = Profile.GetProfile(utente);
    profile.UserAlbumID = albumID;

    profile.Save();
    Roles.AddUserToRole(utente, "Administrator");
    Response.Redirect("~/Admin/ManageUser.aspx");
  }

  protected void ButtonAnnulla_Click(object sender, EventArgs e)
  {
    Response.Redirect("~/Admin/ManageUser.aspx");
  }
 
}
