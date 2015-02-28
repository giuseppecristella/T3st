using System;
using System.Diagnostics;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
public partial class Admin_Photos_aspx : System.Web.UI.Page
{
  private bool _refreshState;
  private bool _isRefresh;
  protected override void LoadViewState(object savedState)
  {
    var AllStates = (object[])savedState;
    base.LoadViewState(AllStates[0]);
    _refreshState = bool.Parse(AllStates[1].ToString());
    _isRefresh = _refreshState == bool.Parse(Session["__ISREFRESH"].ToString());
  }

  protected override object SaveViewState()
  {
    Session["__ISREFRESH"] = _refreshState;
    object[] AllStates = new object[2];
    AllStates[0] = base.SaveViewState();
    AllStates[1] = !(_refreshState);
    return AllStates;
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack) //check if the webpage is loaded for the first time.
    {
      ViewState["PreviousPage"] = Request.UrlReferrer; //Saves the Previous page url in ViewState
    }
    var AlbumID = int.Parse(Request.QueryString["AlbumID"]);

    var taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlbum = taAlbums.GetInfoAlbumbyID(AlbumID);
    var taP = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
    DataTable dtPhotos = taP.GetFotoByAlbumID(AlbumID);
    if (dtPhotos.Rows.Count == 0) btnChangePos.Visible = false;

    lvFoto.DataSource = dtPhotos;
    lvFoto.DataBind();

    // check sul tipo
    switch (dtAlbum.Rows[0]["TipoAlbum"].ToString())
    {
      case "0":
      case "1":
        lblNomeAlb.Text = PhotoManager.GetNomeAlbum_join(AlbumID);
        break;
      case "2":
      case "3":
        lblNomeAlb.Text = PhotoManager.GetNomeAlbum(AlbumID);
        break;
    }
  }

  protected void btnBack_Click(object sender, EventArgs e)
  {
    var albumId = int.Parse(Request.QueryString["AlbumID"]);
    var taAlb = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taAlb.GetInfoAlbumbyID(albumId);
    if (dtAlb.Rows.Count == 0) PhotoManager.RemoveAlbum(albumId);
    if (ViewState["PreviousPage"] != null)	//Check if the ViewState contains Previous page URL
    {
      Response.Redirect(ViewState["PreviousPage"].ToString());//Redirect to Previous page by retrieving the PreviousPage Url from ViewState.
    }
  }

  protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    if (((Byte[])e.Values["BytesOriginal"]).Length == 0)
      e.Cancel = true;
  }

  protected void AggiungiFoto(object sender, EventArgs e)
  {
    var AlbumID = int.Parse((string)Request.QueryString["AlbumID"]);
    var caption = PhotoCaption.Text;
    byte[] photoBytes = PhotoFile.FileBytes;
    var taphotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
    DataTable dtphotos = taphotos.GetFotoByAlbumID(AlbumID);
    int ordine = dtphotos.Rows.Count + 1;
    PhotoManager.AddPhotoMultiLingue(AlbumID, caption, photoBytes, ordine, PhotoCaption2.Text, PhotoCaption3.Text);
  }

  protected void lvFoto_OnItemCommand(object sender, ListViewCommandEventArgs e)
  {
    var item = e.Item as ListViewDataItem;
    if (item == null) return;

    var dataKey = lvFoto.DataKeys[item.DisplayIndex];
    if (dataKey == null) return;

    var photoId = dataKey.Value.ToString();
    if (e.CommandName == "cancella")
    {
      var albumId = int.Parse((string)Request.QueryString["AlbumID"]);
      var taphotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
      DataTable dtphotos = taphotos.GetPhotosByPos(albumId);
      for (int i = 0; i < dtphotos.Rows.Count; i++)
      {
        if (dtphotos.Rows[i]["PhotoID"].ToString() != photoId) continue;
        if (i + 1 == dtphotos.Rows.Count)
        {
          //cancella
          taphotos.Delete(int.Parse(photoId));
        }
        else
        {
          //shift sx di uno
          for (int j = i + 1; j < dtphotos.Rows.Count; j++)
          //faccio delle update dell'ordine
          {
            taphotos.UpdateOrdineFoto(j, int.Parse(dtphotos.Rows[j]["PhotoID"].ToString()));
          }
          //cancello la foto
          taphotos.Delete(int.Parse(photoId));
        }
      }
      //prima di cancellare devo riassegnare le posizioni per ogni foto
      //se la foto da cancellare è l'ultima posso eliminarla direttamente
    }
    if (e.CommandName == "updateCaption")
    {

      var txtCaption = item.FindControl("txtCaption") as TextBox;
      if (txtCaption != null) txtCaption.Attributes.Add("style", "background:yellow;");
      var txtCaptionEN = item.FindControl("txtCaptionEN") as TextBox;
      var txtCaptionDE = item.FindControl("txtCaptionDE") as TextBox;

      var taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
      if (txtCaptionEN != null && txtCaptionDE != null)
        taPhotos.UpdateCaption(txtCaption.Text, txtCaptionEN.Text, txtCaptionDE.Text, int.Parse(photoId));
    }
    lvFoto.DataBind();
  }

  protected void btnUploadFoto_Click(object sender, EventArgs e)
  {
    if (!_isRefresh)
    {
      int albumId = int.Parse((string)Request.QueryString["AlbumID"]);
      var caption = PhotoCaption.Text;
      byte[] photoBytes = PhotoFile.FileBytes;
      //devo recuperare tutte le foto dell'album per trovare la prima posizione disponibile
      var taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
      DataTable dtPhotos = taPhotos.GetFotoByAlbumID(albumId);
      var ordine = dtPhotos.Rows.Count + 1;
      PhotoManager.AddPhotoMultiLingue(albumId, caption, photoBytes, ordine, PhotoCaption2.Text, PhotoCaption3.Text);
      lvFoto.DataBind();
      PhotoCaption.Text = string.Empty;
      PhotoCaption2.Text = string.Empty;
      PhotoCaption3.Text = string.Empty;
      btnChangePos.Visible = true;
    }
  }

  protected void btnChangePos_Click(object sender, EventArgs e)
  {
    var strarrPos = hdfArrPos.Value;
    var albId = Request.QueryString["AlbumID"];
    string[] splitted = strarrPos.Split(new string[] { "&" }, StringSplitOptions.RemoveEmptyEntries);
    var taPhoto = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
    //alb id=3 per lo sliderhome
    DataTable dtPhotos = taPhoto.GetFotoByAlbumID(int.Parse(albId));
    for (var i = 0; i < splitted.Length; i++)
    {
      for (int j = 0; j < dtPhotos.Rows.Count; j++)
      {
        if (dtPhotos.Rows[j]["ordine"].ToString() == splitted[i])
        {
          var photoId = int.Parse(dtPhotos.Rows[j]["PhotoId"].ToString());
          taPhoto.UpdateOrdineFoto(i + 1, photoId);
        }
      }
    }
    lvFoto.DataBind();
  }

  protected void gotosliderPage(object sender, EventArgs e)
  {
    var taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(2);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }

  protected void gotoSpecial(object sender, EventArgs e)
  {
    var taA = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlb = taA.GetAlbumByTipo(3);
    if (dtAlb.Rows.Count > 0)
      Response.Redirect("Photos.aspx?AlbumID=" + dtAlb.Rows[0]["AlbumID"].ToString());
  }

}