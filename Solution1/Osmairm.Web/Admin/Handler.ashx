<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.IO;
using System.Web;

public class Handler : IHttpHandler
{
    public bool IsReusable
    {
        get
        {
            return true;
        }
    }

    public void ProcessRequest(HttpContext context)
    {
        // Impostare le opzioni di risposta
        context.Response.ContentType = "image/jpeg";
        context.Response.Cache.SetCacheability(HttpCacheability.Public);
        context.Response.BufferOutput = false;

        // la foto non viene presa dal db!!
        if (context.Request.QueryString["Path"] != null && context.Request.QueryString["Path"] != "")
        {
            string pathFoto = context.Request.QueryString["Path"];
            // preparo lo stream e lo mostro

            // controllo se devo ridimensionarla ulteriormente
            if ((!string.IsNullOrEmpty((string)context.Request.QueryString["W_"])) && (!string.IsNullOrEmpty((string)context.Request.QueryString["H_"])))
            {
                int imgWidth = int.Parse((string)context.Request.QueryString["W_"]);
                int imgHeight = int.Parse((string)context.Request.QueryString["H_"]);


                if (!string.IsNullOrEmpty((string)context.Request.QueryString["P_"]))
                {
                    MemoryStream m = PhotoManager.MyResizeImageFilePathP(pathFoto, new byte[0], imgWidth, imgHeight);
                    byte[] newImageByte = m.GetBuffer();
                    HttpContext.Current.Response.OutputStream.Write(newImageByte, 0, newImageByte.Length);

                }
                else
                {

                    MemoryStream m = PhotoManager.MyResizeImageFile(pathFoto, new byte[0], imgWidth, imgHeight);

                    byte[] newImageByte = m.GetBuffer();
                    HttpContext.Current.Response.OutputStream.Write(newImageByte, 0, newImageByte.Length);
                
                }
                
                
                
            }
        }
        else// foto presa dal db
        {
            // Impostare il parametro Size
            PhotoSize size;
            switch (context.Request.QueryString["Size"])
            {
                case "S":
                    size = PhotoSize.Small;
                    break;
                case "M":
                    size = PhotoSize.Medium;
                    break;
                case "L":
                    size = PhotoSize.Large;
                    break;
                default:
                    size = PhotoSize.Original;
                    break;
            }
            // Impostare il parametro PhotoID
            Int32 id = -1;
            Stream stream = null;
            if (context.Request.QueryString["PhotoID"] != null && context.Request.QueryString["PhotoID"] != "")
            {
                string strPhotoID = context.Request.QueryString["PhotoID"].Replace(".jpg", "");
                id = Convert.ToInt32(strPhotoID);

                stream = PhotoManager.GetPhoto(id, size);
            }
            else
            {
                id = Convert.ToInt32(context.Request.QueryString["AlbumID"]);
                stream = PhotoManager.GetFirstPhotobyPos(id, size);/*modifica peppe per recuperare la preview negli album della foto in posizione 1*/
            
            
            
            }
            // Recuperare la foto dal database. Se non viene restituito alcun elemento, recuperare la foto predefinita "segnaposto"
            if (stream == null) stream = PhotoManager.GetPhoto(size);
            // Scrivere il flusso immagini nel flusso di risposta

            // controllo se devo ridimensionarla ulteriormente
            if ((!string.IsNullOrEmpty((string)context.Request.QueryString["W_"])) &&
                (!string.IsNullOrEmpty((string)context.Request.QueryString["H_"])))
            {
                int imgWidth = int.Parse((string)context.Request.QueryString["W_"]);
                int imgHeight = int.Parse((string)context.Request.QueryString["H_"]);

                int buffersize = (int)stream.Length;
                byte[] buffer = new byte[buffersize];
                int count = stream.Read(buffer, 0, buffersize);
                while (count > 0)
                {
                    count = stream.Read(buffer, 0, buffersize);
                }
                if (!string.IsNullOrEmpty((string)context.Request.QueryString["P_"]))
                {
                    MemoryStream m = PhotoManager.ResizeImageFileP(buffer, imgWidth, imgHeight);
                    byte[] newImageByte = m.GetBuffer();
                    HttpContext.Current.Response.OutputStream.Write(newImageByte, 0, newImageByte.Length);

                }
                else
                {


                    MemoryStream m = PhotoManager.MyResizeImageFile("", buffer, imgWidth, imgHeight);
                    byte[] newImageByte = m.GetBuffer();
                    HttpContext.Current.Response.OutputStream.Write(newImageByte, 0, newImageByte.Length);
                }
               
            }
            else
            {
                const int buffersize = 1024 * 16;
                byte[] buffer = new byte[buffersize];
                int count = stream.Read(buffer, 0, buffersize);
                while (count > 0)
                {
                    context.Response.OutputStream.Write(buffer, 0, count);
                    count = stream.Read(buffer, 0, buffersize);
                }
            }
        }
    }
}