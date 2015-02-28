using System;
using System.IO;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using DataSetVepAdminTableAdapters;
 
public partial class Azienda : System.Web.UI.Page
{

  protected void Page_Load(object sender, EventArgs e)
  {
    if (IsPostBack) return;
    var strTemplateAzienda = readTemplateFromFile("template_azienda.html");
    literalTemplate.Text = strTemplateAzienda;
    //elimino i link ai css
    literalTemplate.Text = literalTemplate.Text.Remove(0, literalTemplate.Text.LastIndexOf("<!--CSS-->"));
    var table = new DataSetVepAdmin.NewsDataTable();
    var taNews = new NewsTableAdapter();
    taNews.GetListaNews_OrderASC("21");
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

  static string readTemplateFromFile(string templateType)
  {
    var fileName = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + templateType);
    var output = "";
    if (!File.Exists(fileName)) return output;
    var stFile = File.OpenText(fileName);
    output = stFile.ReadToEnd();
    stFile.Close();
    return output;
    /* lavoro sui repater dell'archivio mesi qui siccome faccio una select group by e count che restituisce delle colonne nulle o 
     che violano i vincoli di non unicità, utilizzo la fill e catturo l'eccezione, la tabella datatable viene riempita lo stesso */
  }

  protected void rptArchivioItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    var item = e.Item;
    var itemRow = (DataRowView)item.DataItem;
    var htmlAnchorItem = new HtmlGenericControl
    {
      InnerHtml =
        string.Format("<li><a href=\"Blog.aspx?Mese={0}&Anno={1}\">{2}&nbsp;{1}&nbsp;" + "({3}) </a></li>",
        itemRow["Mese"], itemRow["Anno"],
        System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(itemRow["Mese"].ToString())), 
        itemRow["Numero"])
    };
    item.Controls.Add(htmlAnchorItem);
  }

}
