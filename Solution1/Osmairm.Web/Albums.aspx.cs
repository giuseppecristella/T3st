using System;
using System.Collections;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Albums : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string strTemplateAzienda = "";
    if (IsPostBack) return;
    var taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
    var arrTags = new ArrayList();
    var taAlbum = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();

    DataTable dtSrc = taAlbum.GetAlbums(0, 2); // uso questa query perchè devo recuperare le info sui tags
    foreach (DataRow drw in dtSrc.Rows)
    {
      DataTable dtNewsList = taNews.GetDataByID(int.Parse(drw["News_ID"].ToString()));
      var tagSplitted = dtNewsList.Rows[0]["Tags"].ToString().Split(',');
      foreach (string t in tagSplitted)
      {
        if (!arrTags.Contains(t))
        {
          arrTags.Add(t);
        }
      }
    }
    rptTags.DataSource = arrTags;
    rptTags.DataBind();
  }

  protected void rptPhotos_OnDataBound(object sender, RepeaterItemEventArgs e)
  {
    var dataItem = e.Item;
    if (dataItem.ItemIndex == 0)
    {
      var pnlDettaglio = dataItem.FindControl("pnlDettaglio") as Panel;
      if (pnlDettaglio != null)
        pnlDettaglio.Visible = true;
    }
  }

  protected void rptTags_OnItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    var dataItem = e.Item;

    var tag = Request.QueryString["tag"];
    var liTag = dataItem.FindControl("li_tag") as HtmlGenericControl;
    if ((string)dataItem.DataItem == tag)
    {
      if (liTag != null)
        liTag.InnerHtml =
          string.Format("<a class=\"tag-active\" href=\"Albums.aspx?tag={0}\" >{0}</a>", dataItem.DataItem);
    }
    else if (liTag != null)
      liTag.InnerHtml =
        string.Format("<a class=\"tag-celeste\" href=\"Albums.aspx?tag={0}\" >{0}</a>", dataItem.DataItem);
  }

  protected void lvAlbums_OnItemCreated(object sender, ListViewItemEventArgs e)
  {
    if (e.Item.ItemType != ListViewItemType.DataItem) return;
    var item = (ListViewDataItem)e.Item;
    if (item.DataItem == null) return;
    var rowView = (DataRowView)item.DataItem;
    var albumId = rowView["AlbumID"].ToString();
    var taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
    
    var dtPhotos = taPhotos.GetDataPhotos_joinNewsbyAlId(int.Parse(albumId));
    var rptPhotos = (Repeater)e.Item.FindControl("rptPhotos");
    rptPhotos.DataSource = dtPhotos;
    rptPhotos.DataBind();
  }

  protected void pagerAlbums_PreRender(object sender, EventArgs e)
  {
    DataTable dtDest;
    var taAlbum = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    var taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
    var taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();

    if (!String.IsNullOrEmpty(Page.Request.QueryString["Tag"]))
    {
      var dtSrcFromTag = new DataSetVepAdmin.NewsDataTable();
      try
      {
        taNews.FillAlbumsByTagsANDTipi(dtSrcFromTag, Page.Request.QueryString["Tag"], "1", "2", "90", "90");
      }
      catch (ConstraintException ex)
      {

      }
      dtDest = dtSrcFromTag.Clone();
      /*visualizzo solo gli albums che hanno foto*/
      foreach (DataRow dr in dtSrcFromTag.Rows)
      {
        DataTable dtPhotoCount = taPhotos.GetFotoByAlbumID(int.Parse(dr["AlbumID"].ToString()));
        if (dtPhotoCount.Rows.Count > 0)
        {
          DataRow newRow = dtDest.NewRow();
          newRow.ItemArray = dr.ItemArray;
          dtDest.Rows.Add(newRow);
        }
      }
    }
    else
    {
      DataTable dtSrc = taAlbum.GetAlbums(0, 2);
      dtDest = dtSrc.Clone();
      /*visualizzo solo gli albums che hanno foto*/
      foreach (DataRow dr in dtSrc.Rows)
      {
        DataTable dtPhotoCount = taPhotos.GetFotoByAlbumID(int.Parse(dr["AlbumID"].ToString()));
        if (dtPhotoCount.Rows.Count <= 0) continue;
        DataRow newRow = dtDest.NewRow();
        newRow.ItemArray = dr.ItemArray;
        dtDest.Rows.Add(newRow);
      }
    }
    var isPagerVisible = (dtDest.Rows.Count > DataPagerlvAlbum.PageSize);
    DataPagerlvAlbum.Visible = isPagerVisible;
    lvAlbums.DataSource = dtDest;
    lvAlbums.DataBind();
  }

}
