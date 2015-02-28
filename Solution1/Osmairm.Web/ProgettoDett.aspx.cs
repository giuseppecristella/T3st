using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DataSetVepAdminTableAdapters;

public partial class ProgettoDett : System.Web.UI.Page
{
    string queryStr = "";
    int newsID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        newsID = int.Parse(Request.QueryString["Id"]);

        if (!Page.IsPostBack)
        {
           // 





            HtmlAnchor htmlAnchorProgetti = (HtmlAnchor)Page.Master.FindControl("htmlAnchorProgetti");
            if (htmlAnchorProgetti!=null)
            htmlAnchorProgetti.Style["color"] = "#bbb";
            DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new NewsTableAdapter();
            DataTable dtNews = taNews.GetDataByID(newsID);
            rptNews.DataSource = dtNews;
            rptNews.DataBind();
            setPriority();

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

             
             dtNews = taNews.GetListaNews_OrderASC("21");
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


    }


    

    public void setPriority()
    {



        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbume = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlbum = taAlbume.GetIdAlbum(newsID);

        DataSetVepAdminTableAdapters.NewsTableAdapter taNew = new DataSetVepAdminTableAdapters.NewsTableAdapter();
        DataTable dtNew = taNew.GetDataByID(newsID);

        string pathPhotoNew = dtNew.Rows[0]["UrlFotoHome"].ToString();

        /*se c'è un video lo visualizzo*/
        if (!string.IsNullOrEmpty(dtNew.Rows[0]["Video"].ToString()))
        {

            rptNews.Items[0].FindControl("divVideo").Visible = true;

        }
        else
            /*se c'è un album con delle foto!!! lo visualizzo*/

            if (dtAlbum.Rows.Count > 0)
            {
                DataSetVepAdminTableAdapters.PhotosTableAdapter taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
                DataTable dtPhotos = taPhotos.GetDataPhotos_joinNewsbyAlId(int.Parse(dtAlbum.Rows[0]["AlbumID"].ToString()));

                if (dtPhotos.Rows.Count > 0)
                {

                    rptNews.Items[0].FindControl("SliderAlbum").Visible = true;

                    Repeater rptBIG = (Repeater)rptNews.Items[0].FindControl("rptBigThumb");
                    rptBIG.DataSource = dtPhotos;
                    rptBIG.DataBind();
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


    protected void rptArchivioItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        RepeaterItem item = (RepeaterItem)e.Item;
        DataRowView itemRow = (DataRowView)item.DataItem;
        HtmlGenericControl htmlAnchorItem = new HtmlGenericControl();

        //href=\"Blog.aspx?Mese=" + dtDest.Rows[repeatItem.ItemIndex]["Mese"].ToString() + "&Anno=" + dtDest.Rows[repeatItem.ItemIndex]["Anno"].ToString() + "\">" + System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(dtDest.Rows[repeatItem.ItemIndex]["Mese"].ToString())).ToString() + "<span>(" + dtDest.Rows[repeatItem.ItemIndex]["Numero"].ToString() + ")</span></a></li>";
       // repeatItem.Controls.Add(lbl);
        htmlAnchorItem.InnerHtml = "<li><a href=\"Blog.aspx?Mese=" + itemRow["Mese"] + "&Anno=" + itemRow["Anno"] + "\">" + System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(itemRow["Mese"].ToString())) + "&nbsp;" + itemRow["Anno"] + "&nbsp;" + "(" + itemRow["Numero"] + ") </a></li>";
        item.Controls.Add(htmlAnchorItem);
    }
    
    protected void rptNewsItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataRowView dataRow = (DataRowView)e.Item.DataItem;
        string[] _tags = dataRow["Tags"].ToString().Split(',');
        for (int i = 0; i < _tags.Length; i++)
        {
            HtmlGenericControl divTags = new HtmlGenericControl();
            divTags = (HtmlGenericControl)e.Item.FindControl("divNewsTag");
            divTags.InnerHtml += "<a class=\"tag-celeste\"  href=\"Progetti.aspx?tag=" + _tags[i] + "\">" + _tags[i] + "</a>";
        }

    }
}
