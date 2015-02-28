using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DataSetVepAdminTableAdapters;

public partial class NewsDetail : System.Web.UI.Page
{
  string queryStr = "";
  int newsID = 0;

  protected void Page_Load(object sender, EventArgs e)
  {

    if (!Page.IsPostBack)
    {
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new NewsTableAdapter();
      DataTable dtNews = taNews.GetListaNews_OrderASC("21");
      rptNews.DataSource = dtNews;
      rptNews.DataBind();
      DataSetVepAdmin.NewsDataTable table = new DataSetVepAdmin.NewsDataTable();

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

      //   ClientScript.RegisterClientScriptBlock(this.GetType(), "blah", "getHeight();", true);
    }
  }

  public void setPriority(RepeaterItem item)
  {
    DataRowView dataRow = (DataRowView)item.DataItem;
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbume = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    DataTable dtAlbum = taAlbume.GetIdAlbum(int.Parse(dataRow["News_ID"].ToString()));
    DataSetVepAdminTableAdapters.NewsTableAdapter taNew = new DataSetVepAdminTableAdapters.NewsTableAdapter();
    string pathPhotoNew = dataRow["UrlFotoHome"].ToString();
    Literal ltrPostMediaOpen = (Literal)item.FindControl("ltrPostMediaOpen");
    Literal ltrPostMediaClose = (Literal)item.FindControl("ltrPostMediaClose");
    /*se c'è un video lo visualizzo*/
    if (!string.IsNullOrEmpty(dataRow["Video"].ToString()))
    {
      //  item.FindControl("divVideo").Visible = true;
    }
    else
      /*se c'è un album con delle foto!!! lo visualizzo*/
      if (dtAlbum.Rows.Count > 0)
      {
        DataSetVepAdminTableAdapters.PhotosTableAdapter taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
        DataTable dtPhotos = taPhotos.GetDataPhotos_joinNewsbyAlId(int.Parse(dtAlbum.Rows[0]["AlbumID"].ToString()));

        if (dtPhotos.Rows.Count > 0)
        {
          if (ltrPostMediaOpen != null)
            ltrPostMediaOpen.Text = "<div class=\"post-media\"><div class=\"flexslider\"><ul class=\"slides\">";
          Repeater rptBIG = (Repeater)item.FindControl("rptBigThumb");
          if (rptBIG != null)
          {
            rptBIG.DataSource = dtPhotos;
            rptBIG.DataBind();
            if (ltrPostMediaClose != null)
              ltrPostMediaClose.Text = "</ul></div></div>";
          }
        }
        /*altrimenti scatta la foto singola della news*/
        else if (pathPhotoNew != "img/Foto/standardNews.jpg")
        {
          ltrPostMediaOpen.Text = "<div class=\"post-media\"><img src=\"" + dataRow["UrlFotoHome"].ToString() + "\" />";
          ltrPostMediaClose.Text = "</div>";
          // item.FindControl("divFoto").Visible = true;
        }
      }
      else if (pathPhotoNew != "img/Foto/standardNews.jpg")
      {
        ltrPostMediaOpen.Text = "<div class=\"post-media\"><img src=\"" + dataRow["UrlFotoHome"].ToString() + "\" />";
        ltrPostMediaClose.Text = "</div>";
      }
  }

  protected void rptArchivioItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    RepeaterItem item = (RepeaterItem)e.Item;
    DataRowView itemRow = (DataRowView)item.DataItem;
    HtmlGenericControl htmlAnchorItem = new HtmlGenericControl();

    htmlAnchorItem.InnerHtml = "<li><a href=\"Blog.aspx?Mese=" + itemRow["Mese"] + "&Anno=" + itemRow["Anno"] + "\">" + System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(itemRow["Mese"].ToString())) + "&nbsp;" + itemRow["Anno"] + "&nbsp;" + "(" + itemRow["Numero"] + ") </a></li>";
    item.Controls.Add(htmlAnchorItem);
  }

  protected void rptNewsItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    Literal ltrlDivOpenPost = (Literal)e.Item.FindControl("ltrlDivOpenPost");

    if (ltrlDivOpenPost != null)
      ltrlDivOpenPost.Text = "<div style=\"float:left;min-height:300px; display: block; width: 100%;\" class=\"post-single\"   id=\"struttura-" + (e.Item.ItemIndex + 1).ToString() + "\"><div  class=\"post\">";

    RepeaterItem item = (RepeaterItem)e.Item;
    DataRowView dataRow = (DataRowView)e.Item.DataItem;
    setPriority(item);

    var mappa_piccola = (HtmlAnchor)item.FindControl("mappa_piccola");
    if (mappa_piccola != null)
    {
      if (String.IsNullOrEmpty(dataRow["DescrizioneTED"].ToString()))
      {
        mappa_piccola.Visible = false;
      }
    }

    var anchAllegati = (HtmlAnchor)item.FindControl("anchAllegati");
    if (anchAllegati != null)
    {
      if (String.IsNullOrEmpty(dataRow["Allegati"].ToString()))
        anchAllegati.Visible = false;
    }
  }

  protected void rptItemCreated(object sender, EventArgs e)
  {
  }

}
