using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.XPath;
using DataSetVepAdminTableAdapters;

public partial class Blog : System.Web.UI.Page
{
  private string anno = "2013";

  protected void Page_Load(object sender, EventArgs e)
  {

    /*creo dinamicamente n repeater per i tags bindati all'oggetto XmlDataSourceTags
     per realizzare il bind dinamico e la relativa costruzione degli items ho dovuto
     * gestire l'evento ItemDataBound da codice, intercettando a runtime il binding
     * e lavorando poi sull'oggetto XPathNavigator dopo aver eseguito un cast del singolo
     * item del repeater sul tipo IXPathNavigable
         
     * 
     * non uso questa soluzione perchè ho bisogno di splittare il file xml
     */

    /*   Repeater rptTags = new Repeater();
       rptTags.DataSource = XmlDataSourceTags;
       rptTags.ItemDataBound += new RepeaterItemEventHandler(rptTags_ItemDataBound);
       rptTags.DataBind();*/

    //if (!Page.IsPostBack)
    //{

    DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new NewsTableAdapter();
    HtmlAnchor htmlAnchorBlog = (HtmlAnchor)Page.Master.FindControl("htmlAnchorBlog");
    if (htmlAnchorBlog != null)
      htmlAnchorBlog.Style["color"] = "#bbb";
    DataSetVepAdminTableAdapters.AlbumsTableAdapter taAl = new AlbumsTableAdapter();
    DataSetVepAdminTableAdapters.NewsTableAdapter taNw = new NewsTableAdapter();
    DataTable dtNewsFoto = taNw.GetNewswithFoto();
    DataTable dtNewsVideo = taNw.GetNewswithVideo();
    DataTable dtNewsGallery = taAl.GetAlbumByTipo_joinNews(0);
    ltrNewsType.Text = "<a href=\"Blog.aspx?Media=video" + "\">Video</a>" + "<a href=\"Blog.aspx?Media=gallery\">Gallery</a>" + "<a href=\"Blog.aspx?Media=foto\">Foto</a>";
    XmlDocument doc = XmlDataSourceTags.GetXmlDocument();
    int count = doc.SelectNodes("/News/TipoNews/TipoNews_Item").Count;

    /*carico un arraylist dall'xml*/

    ArrayList arrFromXmlTags = new ArrayList();
    XPathNavigator xNav = XmlDataSourceTags.GetXmlDocument().CreateNavigator();
    XPathNodeIterator xPathId = xNav.Select("//News//TipoNews//TipoNews_Item//Id_TipologiaNews");
    XPathNodeIterator xPathDesc = xNav.Select("//News//TipoNews//TipoNews_Item//Descrizione_Tipologia");
    XPathNodeIterator xPathTipoNews = xNav.Select("//News//TipoNews");

    while (xPathId.MoveNext() && xPathDesc.MoveNext() && xPathTipoNews.MoveNext())
    {
      arrFromXmlTags.Add(xPathDesc.Current.Value);
    }

    int numRowTagsToShow = 9;

    /*calcolo quanti repeater mi servono*/
    int numRepeaterTags = 1;
    if (count / numRowTagsToShow != 0)
      numRepeaterTags = (count / numRowTagsToShow) + (count % numRowTagsToShow);
    for (int i = 0; i < numRepeaterTags; i++)
    {
      ArrayList splitXml = new ArrayList();
      for (int j = numRowTagsToShow * i; j < numRowTagsToShow * i + numRowTagsToShow; j++)
      {
        if (j < arrFromXmlTags.Count)
          splitXml.Add(arrFromXmlTags[j]);
      }
      Repeater rptTagsSplitted = new Repeater();
      rptTagsSplitted.DataSource = splitXml;
      rptTagsSplitted.DataBind();

      foreach (RepeaterItem repeatItem in rptTagsSplitted.Items)
      {
        // if condition to add HeaderTemplate Dynamically only Once  
        if (repeatItem.ItemIndex == 0)
        {
          RepeaterItem headerItem = new RepeaterItem(repeatItem.ItemIndex, ListItemType.Header);
          Literal ltrUlOpenTAg = new Literal();
          ltrUlOpenTAg.Text = "<ul>";
          repeatItem.Controls.Add(ltrUlOpenTAg);
        }
        RepeaterItem repeaterItem = new RepeaterItem(repeatItem.ItemIndex, ListItemType.Item);
        Literal lbl = new Literal();
        lbl.Text = "<li><a href=\"Blog.aspx?Tag=" + (string)splitXml[repeatItem.ItemIndex] + "\">" + (string)splitXml[repeatItem.ItemIndex] + "</span></a></li>";
        repeatItem.Controls.Add(lbl);
        if (repeatItem.ItemIndex == rptTagsSplitted.Items.Count - 1)
        {
          RepeaterItem footerItem = new RepeaterItem(repeatItem.ItemIndex, ListItemType.Footer);
          Literal ltrUlCloseTag = new Literal();

          ltrUlCloseTag.Text = "</ul>";
          repeatItem.Controls.Add(ltrUlCloseTag);
        }
      }
      categories.Controls.Add(rptTagsSplitted);
    }

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
    int numRowToShow = 9;
    /*calcolo quanti repeater mi servono*/
    int numRepeater = 1;
    if (table.Rows.Count / numRowToShow != 0)
      numRepeater = (table.Rows.Count / numRowToShow) + (table.Rows.Count % numRowToShow);

    /*distribuisco le righe a gruppi di 9 delimitandoli con degli ul*/
    for (int i = 0; i < numRepeater; i++)
    {
      /*copio i dati a gruppi di 9*/
      DataSetVepAdmin.NewsDataTable dtDest = new DataSetVepAdmin.NewsDataTable();
      try
      {
        dtDest = (DataSetVepAdmin.NewsDataTable)table.Clone();
      }
      catch (ConstraintException ex)
      {

      }
      for (int j = numRowToShow * i; j < numRowToShow * i + numRowToShow; j++)
      {
        DataRow newRow = dtDest.NewRow();
        if (j < table.Rows.Count)
        {
          newRow.ItemArray = table.Rows[j].ItemArray;
          //purtroppo restituendo una tabella con colonne nulle vado in eccezione e quindi metto dei valori vuoti nelle colonne
          // che non accettano un valore null di default
          newRow["Titolo"] = "";
          newRow["Testo"] = "";
          newRow["Data"] = System.DateTime.Now;
          dtDest.Rows.Add(newRow);
        }
      }
      /*creo e bindo il repeater*/
      Repeater rptArchivioMeseAnno = new Repeater();
      rptArchivioMeseAnno.DataSource = dtDest;
      rptArchivioMeseAnno.DataBind();
      //questo oggetto mi permette di recuperare il nome del mese -> forse devo impostare la cultura italiana!!
      //System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();

      //creo gli n. repeater
      foreach (RepeaterItem repeatItem in rptArchivioMeseAnno.Items)
      {
        // if condition to add HeaderTemplate Dynamically only Once  
        if (repeatItem.ItemIndex == 0)
        {
          RepeaterItem headerItem = new RepeaterItem(repeatItem.ItemIndex, ListItemType.Header);
          Literal ltrUlOpenTAg = new Literal();

          if (i == 0)
          {

            ltrUlOpenTAg.Text = "<ul><li><strong>" + dtDest.Rows[repeatItem.ItemIndex]["Anno"].ToString() + "</strong></li>";
          }
          else
          {
            ltrUlOpenTAg.Text = "<ul>";
          }

          repeatItem.Controls.Add(ltrUlOpenTAg);
        }
        // Add ItemTemplate DataItems Dynamically  
        RepeaterItem repeaterItem = new RepeaterItem(repeatItem.ItemIndex, ListItemType.Item);

        /*controllo se devo impostare l'anno!!*/
        Literal lblAnno = new Literal();

        if (dtDest.Rows[repeatItem.ItemIndex]["Anno"].ToString() != anno)
        {
          anno = dtDest.Rows[repeatItem.ItemIndex]["Anno"].ToString();
          lblAnno.Text = "<li><strong>" + dtDest.Rows[repeatItem.ItemIndex]["Anno"].ToString() + "</strong></li>";
        }
        repeatItem.Controls.Add(lblAnno);
        Literal lbl = new Literal();

        lbl.Text = "<li><a href=\"Blog.aspx?Mese=" + dtDest.Rows[repeatItem.ItemIndex]["Mese"].ToString() + "&Anno=" + dtDest.Rows[repeatItem.ItemIndex]["Anno"].ToString() + "\">" + System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(dtDest.Rows[repeatItem.ItemIndex]["Mese"].ToString())).ToString() + "<span>(" + dtDest.Rows[repeatItem.ItemIndex]["Numero"].ToString() + ")</span></a></li>";
        repeatItem.Controls.Add(lbl);
        if (repeatItem.ItemIndex == rptArchivioMeseAnno.Items.Count - 1)
        {
          RepeaterItem footerItem = new RepeaterItem(repeatItem.ItemIndex, ListItemType.Footer);
          Literal ltrUlCloseTag = new Literal();

          ltrUlCloseTag.Text = "</ul>";
          repeatItem.Controls.Add(ltrUlCloseTag);
        }
      }
      months.Controls.Add(rptArchivioMeseAnno);
    }
  }

  protected void lvBlogPost_OnItemDataBound(object sender, ListViewItemEventArgs e)
  {
    var item = e.Item as ListViewDataItem;
    if (item == null) return;
    var itemRow = (DataRowView)item.DataItem;

    var ltrTitolo = item.FindControl("ltrTitolo") as Literal;
    if (ltrTitolo == null) return;
    ltrTitolo.Text = string.Format("<a href=\"NewsDetail.aspx?Id={0}\">{1}</a>", itemRow["News_ID"], itemRow["Titolo"]);

    var ltrLeggiTutto = item.FindControl("ltrLeggiTutto") as Literal;
    if (ltrLeggiTutto == null) return;
    ltrLeggiTutto.Text = string.Format("<a href=\"NewsDetail.aspx?Id={0}\" class=\"more-link\">Leggi tutto &rarr;</a>", itemRow["News_ID"]);
   
    CreateQuotePost(itemRow, item);

    if (!String.IsNullOrEmpty((itemRow["Video"].ToString())))
    {
      AddVideo(item, itemRow);
    }
    else
    {
      var taAlbums = new AlbumsTableAdapter();
      DataTable dtAlbum = taAlbums.GetIdAlbum(int.Parse(itemRow["News_ID"].ToString()));

      if (dtAlbum.Rows.Count > 0)
      {
        AddGallery(dtAlbum, item);
      }
      else if (HasPhoto(itemRow))
      {
        var ltrMedia = item.FindControl("ltrMedia") as Literal;
        ltrMedia.Text = string.Format("<a style=\"width:386px;height:250px;overflow:hidden;\"><img src=\"{0}\"  alt=\"\" /></a>", itemRow["UrlFotoHome"]);
      }
      else if (HasAttachment(itemRow))
      {
        var HtmlGenericControl = (HtmlGenericControl)item.FindControl("divPostMedia");
        HtmlGenericControl.Attributes["class"] = "post-media link";

        var ltrMedia = (Literal)item.FindControl("ltrMedia");
        ltrMedia.Text = string.Format("<a href=\"{0}/{1}\"target=\"_blank\" \">{1}</a>", Utility.GetAbsoluteUrl(), itemRow["Allegati"]);//itemRow["Video"].ToString();
      }
    }
  }

  private static bool HasPhoto(DataRowView itemRow)
  {
    return (itemRow["UrlFotoHome"].ToString() != "img/Foto/standardNews.jpg");
  }

  private static bool HasAttachment(DataRowView itemRow)
  {
    return (!String.IsNullOrEmpty((itemRow["Allegati"].ToString())));
  }

  private static void AddGallery(DataTable dtAlbum, ListViewDataItem item)
  {
    var taPhotos = new PhotosTableAdapter();
    DataTable dtPhotos = taPhotos.GetDataPhotos_joinNewsbyAlId(int.Parse(dtAlbum.Rows[0]["AlbumID"].ToString()));

    const string sliderDivOpenTag = "<div class=\"flexslider\" id=\"_blog-slider\"><ul class=\"slides\">";
    const string sliderDivCloseTag = "</ul></div>";
    var ltrMedia = item.FindControl("ltrMedia") as Literal;
    if (ltrMedia == null) return;
    var sliderDivInnerHtml = "";
    if (dtPhotos.Rows.Count < 5)
    {
      foreach (DataRow dr in dtPhotos.Rows)
      {
        sliderDivInnerHtml += string.Format("<li style=\"width:386px;height:250px;overflow:hidden;\">"
                                            + "<img src=\"Handler.ashx?PhotoID={0}\" alt=\"\"  />" + "</li>",
          dr["PhotoID"]);
      }
    }
    else
    {
      for (int i = 0; i < 5; i++)
      {
        sliderDivInnerHtml += string.Format("<li style=\"width:386px;height:250px;overflow:hidden;\">"
                                            + "<img src=\"Handler.ashx?PhotoID={0}\" alt=\"\"   />" + "</li>",
          dtPhotos.Rows[i]["PhotoID"]);
      }
    }
    ltrMedia.Text = sliderDivOpenTag + sliderDivInnerHtml + sliderDivCloseTag;
  }

  private static void AddVideo(ListViewDataItem item, DataRowView itemRow)
  {
    var HtmlGenericControl = item.FindControl("divPostMedia") as HtmlGenericControl;
    if (HtmlGenericControl != null) HtmlGenericControl.Attributes["class"] = "post-media video";

    var ltrMedia = item.FindControl("ltrMedia") as Literal;
    if (ltrMedia != null) ltrMedia.Text = itemRow["Video"].ToString();
  }

  private static void CreateQuotePost(DataRowView itemRow, ListViewDataItem item)
  {
    bool isQuotePost;
    if ((!bool.TryParse(itemRow["Ws_Flag"].ToString(), out isQuotePost))) return;
    if (!isQuotePost) return;
    var ltrTitolo = item.FindControl("ltrTitolo") as Literal;
    if (ltrTitolo != null) ltrTitolo.Text = itemRow["Titolo"].ToString();
    var postTitle = (HtmlGenericControl) item.FindControl("post_title");
    var postMeta = (HtmlGenericControl) item.FindControl("post_meta");
    var postContent = (HtmlGenericControl) item.FindControl("post_content");
    postTitle.Visible = false;
    postMeta.Visible = false;
    postContent.Attributes["Class"] = "post-content quote";
    var ltrLeggiTutto = item.FindControl("ltrLeggiTutto") as Literal;
    if (ltrLeggiTutto != null) ltrLeggiTutto.Text = string.Empty;
  }

  protected void DataPagegBlogPreRender(object sender, EventArgs e)
  {
    bool isPagerVisible = true;
    var taNews = new NewsTableAdapter();
    if (!String.IsNullOrEmpty(Page.Request.QueryString["Mese"]))
    {
      DataTable dtNews = taNews.GetNewsByMese(decimal.Parse(Page.Request.QueryString["Mese"]),
                                              decimal.Parse(Page.Request.QueryString["Anno"]));
      isPagerVisible = (dtNews.Rows.Count > DataPagerBlog.PageSize);
      lvBlogPost.DataSource = dtNews;
    }
    else if (!String.IsNullOrEmpty(Page.Request.QueryString["Tag"]))
    {
      DataTable dtNews = taNews.GetDataByTag(Page.Request.QueryString["Tag"], "0");
      isPagerVisible = (dtNews.Rows.Count > DataPagerBlog.PageSize);
      lvBlogPost.DataSource = dtNews;
    }
    else if (!String.IsNullOrEmpty(Page.Request.QueryString["Media"]))
    {
      if (Page.Request.QueryString["Media"] == "video")
      {
        DataTable dtNews = taNews.GetNewswithVideo();
        isPagerVisible = (dtNews.Rows.Count > DataPagerBlog.PageSize);
        lvBlogPost.DataSource = dtNews;
      }
      else if (Page.Request.QueryString["Media"] == "foto")
      {
        DataTable dtNews = taNews.GetNewswithFoto();
        isPagerVisible = (dtNews.Rows.Count > DataPagerBlog.PageSize);
        lvBlogPost.DataSource = dtNews;
      }
      else if (Page.Request.QueryString["Media"] == "gallery")
      {
        DataTable dtNews = taNews.GetNewsWithGallery();
        isPagerVisible = (dtNews.Rows.Count > DataPagerBlog.PageSize);
        lvBlogPost.DataSource = dtNews;
      }
    }
    else
    {
      DataTable dtNews = taNews.GetListaNews("0");
      isPagerVisible = (dtNews.Rows.Count > DataPagerBlog.PageSize);
      lvBlogPost.DataSource = dtNews;
    }
    DataPagerBlog.Visible = isPagerVisible;
    lvBlogPost.DataBind();
  }
}
