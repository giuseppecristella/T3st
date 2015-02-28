using System;
using System.Web.Security;
using System.Data;
public partial class Admin_CreaUtente : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
  }
  protected void CreatedUserRedirect(object sender, EventArgs e)
  {
    string utente = CreateUserWizard1.UserName;
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    int albumID = 0;
    int LoginCount = 0;
    albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(utente, true, null, 4));
    ProfileCommon profile = Profile.GetProfile(utente);
    profile.UserAlbumID = albumID;
    profile.LoginsCount = LoginCount;
    profile.Save();
    Roles.AddUserToRole(utente, "User");
    Response.Redirect("~/Admin/ManageUser.aspx");
  }
  protected void ButtonAnnulla_Click(object sender, EventArgs e)
  {
    Response.Redirect("~/Admin/ManageUser.aspx");
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
}
