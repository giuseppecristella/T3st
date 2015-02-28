using System;
using System.Web;
using System.Data;
using System.Xml;
using System.Text.RegularExpressions;
using DataSetVepAdminTableAdapters;

public static class Utility
{
  public static string GetAbsoluteUrl()
  {
    var absoluteUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + VirtualPathUtility.ToAbsolute("~/");
    return absoluteUrl.LastIndexOf("/", StringComparison.Ordinal) != absoluteUrl.Length - 1 ? absoluteUrl : absoluteUrl.Remove(absoluteUrl.Length - 1, 1);
  }

  public static string SearchConfigValue(string keyValue)
  {
    return System.Configuration.ConfigurationManager.AppSettings[keyValue];
  }

  public static string GetDescriptionForTypeFromXml(string idTipo, string xmlName)
  {
    var retString = string.Empty;
    var docNameWithExtension = string.Format("~/{0}.xml", xmlName);
    var xmlFileName = HttpContext.Current.Server.MapPath(docNameWithExtension);

    var _doc = new XmlDocument();
    _doc.Load(xmlFileName);
    var xPathNavigator = _doc.CreateNavigator();
    var xPathId = xPathNavigator.Select("//News//TipoNews//TipoNews_Item//Id_TipologiaNews");
    var xPathDesc = xPathNavigator.Select("//News//TipoNews//TipoNews_Item//Descrizione_Tipologia");
    var xPathTipoNews = xPathNavigator.Select("//News//TipoNews");
    while (xPathId.MoveNext() && xPathDesc.MoveNext() && xPathTipoNews.MoveNext())
    {
      if (xPathId.Current.Value.Equals(idTipo))
      {
        retString = xPathDesc.Current.Value;
      }
    }
    return retString.ToLower();
  }

  public static string GetPhotoUrl(string urlFoto)
  {
    return string.IsNullOrEmpty(urlFoto) ? "../img/foto/standard.png" : string.Format("../{0}", urlFoto);
  }

  public static string NormalizeYouTubeVideoEmbeddedHtml(string youtubeCode)
  {
    if ((!youtubeCode.Contains("frameborder")) && (!youtubeCode.Contains("scr"))) return string.Empty;
    
    var leftPart = youtubeCode.Split(new[] { "frameborder" }, StringSplitOptions.None)[0];
    var iframeLeftPart = leftPart.Split(new[] { "src" }, StringSplitOptions.None)[0];
  
    var videoUrl = leftPart.Split(new[] { "src=\"" }, StringSplitOptions.None)[1].Replace("src=\"", "");
    videoUrl = videoUrl.Remove(videoUrl.Length - 1).Replace("\"", "");
      
    var uri = new Uri(videoUrl);
    videoUrl += string.IsNullOrEmpty(uri.Query) ? "?wmode=transparent" : "&amp;wmode=transparent";
    return string.Format("{0}src=\"{1}\" frameborder=\"{2}", 
      iframeLeftPart, videoUrl, youtubeCode.Split(new[] { "frameborder" }, StringSplitOptions.None)[1]);
  }

  public static bool ShowField(string idNews)
  {
    var taNews = new NewsTableAdapter();
    DataTable dtNews = taNews.GetDataByID(int.Parse(idNews));
    return !string.IsNullOrEmpty(dtNews.Rows[0]["Allegati"].ToString());
  }

  // spostare nella classe MailManager
  public static bool ValidateMailAddress(string email)
  {
    var emailregexp = new Regex("(?<user>[^@]+)@(?<host>.+)");
    return emailregexp.Match(email).Success;
  }

  public static string GetStringTransFromDB(string nomeCampoITA, string nomeCampoENG, string nomeCampoDE, System.Threading.Thread currentCulture)
  {
    string transString = "";
    if (currentCulture.CurrentCulture.ThreeLetterISOLanguageName == "ita")
    { /*IT-->de*/
      transString = nomeCampoDE;
      if (string.IsNullOrEmpty(transString.Trim()))
        transString = nomeCampoITA;
    }
    else if (currentCulture.CurrentCulture.ThreeLetterISOLanguageName == "eng")
    {
      /*EN-->ita*/
      transString = nomeCampoITA;
    }
    else if (currentCulture.CurrentCulture.ThreeLetterISOLanguageName == "deu")
    {
      /*DE-->en*/
      transString = nomeCampoENG;
      // restituisco il valore in italiano se il campo è vuoto
      if (string.IsNullOrEmpty(transString.Trim()))
        transString = nomeCampoITA;
    }
    transString = transString.Replace("'", "&rsquo;");
    transString = transString.Replace("\"", "&quot;");
    transString = transString.Replace("<div>", "");
    transString = transString.Replace("<p>", "");
    transString = transString.Replace("</p>", "");
    transString = transString.Replace("</div>", "");
    return transString;
  }
  
}
