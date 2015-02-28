using System;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DataSetVepAdminTableAdapters;


public partial class NewsDetail : System.Web.UI.Page
{
  string queryStr = "";
  int newsID = 0;
  protected void Page_Load(object sender, EventArgs e)
  {
    newsID = int.Parse(Request.QueryString["Id"]);
    if (Page.IsPostBack) return;
    var htmlAnchorBlog = (HtmlAnchor)Page.Master.FindControl("htmlAnchorBlog");
    if (htmlAnchorBlog != null) htmlAnchorBlog.Style["color"] = "#bbb";
    var taNews = new NewsTableAdapter();
    DataTable dtNews = taNews.GetDataByID(newsID);
    rptNews.DataSource = dtNews;
    rptNews.DataBind();
    SetPriority();
    var table = new DataSetVepAdmin.NewsDataTable();
    /* lavoro sui repater dell'archivio mesi qui siccome faccio una select group by e count che restituisce delle colonne nulle o 
           che violano i vincoli di non unicità, utilizzo la fill e catturo l'eccezione, la tabella datatable viene riempita lo stesso */
    try
    {
      taNews.FillBy8(table);
    }
    catch (ConstraintException ex)
    {
    }
    rptArchivio.DataSource = table;
    rptArchivio.DataBind();
  }
  public void SetPriority()
  {
    var taAlbume = new AlbumsTableAdapter();
    DataTable dtAlbum = taAlbume.GetIdAlbum(newsID);
    var taNew = new NewsTableAdapter();
    DataTable dtNew = taNew.GetDataByID(newsID);
    var pathPhotoNew = dtNew.Rows[0]["UrlFotoHome"].ToString();
    /*se c'è un video lo visualizzo*/
    if (!string.IsNullOrEmpty(dtNew.Rows[0]["Video"].ToString()))
    {
      rptNews.Items[0].FindControl("divVideo").Visible = true;
    }
    else
      /*se c'è un album con delle foto!!! lo visualizzo*/
      if (dtAlbum.Rows.Count > 0)
      {
        var taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
        DataTable dtPhotos = taPhotos.GetDataPhotos_joinNewsbyAlId(int.Parse(dtAlbum.Rows[0]["AlbumID"].ToString()));
        if (dtPhotos.Rows.Count > 0)
        {
          rptNews.Items[0].FindControl("SliderAlbum").Visible = true;
          var rptBig = (Repeater)rptNews.Items[0].FindControl("rptBigThumb");
          rptBig.DataSource = dtPhotos;
          rptBig.DataBind();
        }
        /*altrimenti scatta la foto singola della news*/
        else if (pathPhotoNew != "img/Foto/standardNews.jpg")
        {
          rptNews.Items[0].FindControl("divFoto").Visible = true;
        }
      }
      else if (pathPhotoNew != "img/Foto/standardNews.jpg")
      {
        rptNews.Items[0].FindControl("divFoto").Visible = true;
      }
  }
  protected void rptArchivio_OnItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    var item = e.Item;
    var itemRow = (DataRowView)item.DataItem;
    if (System.Globalization.DateTimeFormatInfo.CurrentInfo == null) return;
    var htmlAnchorItem = new HtmlGenericControl
    {
      InnerHtml =
        string.Format("<li><a href=\"Blog.aspx?Mese={0}&Anno={1}\">{2}&nbsp;{1}&nbsp;" + "({3}) </a></li>"
        , itemRow["Mese"], itemRow["Anno"]
        , System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(itemRow["Mese"].ToString()))
        , itemRow["Numero"])
    };
    item.Controls.Add(htmlAnchorItem);
  }
  protected void rptNews_OnItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    var dataRow = (DataRowView)e.Item.DataItem;
    var _tags = dataRow["Tags"].ToString().Split(',');
    foreach (string t in _tags)
    {
      HtmlGenericControl divTags;
      divTags = e.Item.FindControl("divNewsTag") as HtmlGenericControl;
      divTags.InnerHtml += "<a class=\"tag-celeste\" href=\"Blog.aspx?tag=" + t + "\">" + t + "</a>";
    }
  }
}
