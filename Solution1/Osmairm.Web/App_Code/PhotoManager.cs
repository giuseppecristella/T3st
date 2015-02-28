using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Web;

public class PhotoManager
{

    /*Tipo album
     
     
     * 0->simple
     * 1->news linked
     * 2->slider home
     * 3->contenuti speciali
     
     
     */



    //ritorna l'elenco delle foto ordinate per posizione nell'album
    public static DataTable GetPhotosByPos(int AlbumID)
    {
        DataSetVepAdminTableAdapters.PhotosTableAdapter taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
        DataTable dtPhotos = taPhotos.GetPhotosByPos(AlbumID);
        return dtPhotos;
    
    }

    public static DataTable GetAlbums(int tipo_album)
    {

        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlbums = taAlbums.GetAlbumByTipo(tipo_album);
        return dtAlbums;
    }




    public static DataTable GetAlbumsNewsLinked(int tipo_album)
    {

        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlbums = taAlbums.GetAlbumNewsLinked(tipo_album);
        return dtAlbums;
    }



    public static void AddAlbumNewsLinked(string titolo_news,string titolo_newsEN,string titolo_newsDE,DateTime data_news, int tipo_album,string tags)
    {
        /*per ora non uso questa variabile ma inserisco solo album tipo=simpe=0!!*/
        int tipoA = int.Parse((string)HttpContext.Current.Session["ddlTipoAlbum"]);

        
       

        DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
        object retIdNews = taNews.InsertQuery("_dummy_fonte",
                                             titolo_news,
                                             "_dummy_testo",
                                             data_news,
                                             false,
                                             "dummy_descr",
                                             "2",
                                             "dummy_fotourl",
                                             "dummy_all",
                                             "dummy_video",
                                             titolo_newsEN,
                                             "dummy_autoreEng",
                                             "dummy_descEng",
                                             "dummy_testoEng",
                                             "",
                                             "dummy_descDe",
                                             "dummy_testoDe",
                                             tags,
                                             false);
        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlbums = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        int albumID = Convert.ToInt32(taAlbums.InsertAlbumRetID(titolo_news, true, int.Parse(retIdNews.ToString()), 0));

        /*devo aggiornare il dizionario dei tags*/
        if (!string.IsNullOrEmpty(tags))
        {

            DataSetVepAdminTableAdapters.TagsTableAdapter taTags = new DataSetVepAdminTableAdapters.TagsTableAdapter();

            string[] _tagsEntry = tags.Split(',');

            for (int i = 0; i < _tagsEntry.Length; i++)
            {
                DataTable dtTaginDictionary = taTags.GetDataByTagName(_tagsEntry[i]);
                if (dtTaginDictionary.Rows.Count == 0)
                    taTags.InsertQuery(_tagsEntry[i]);

            }
        }

        HttpContext.Current.Response.Redirect("~/Admin/Photos.aspx?AlbumID=" + albumID.ToString());
    }









    // Metodi relativi alle foto
    public static Stream GetPhoto(int photoid, PhotoSize size)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("GetPhoto", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PhotoID", photoid));
                command.Parameters.Add(new SqlParameter("@Size", (int)size));
                bool filter = !(HttpContext.Current.User.IsInRole("Friends") || HttpContext.Current.User.IsInRole("Administrators"));
                command.Parameters.Add(new SqlParameter("@IsPublic", filter));
                connection.Open();
                object result = command.ExecuteScalar();
                try
                {
                    return new MemoryStream((byte[])result);
                }
                catch
                {
                    return null;
                }
            }
        }
    }

    public static Stream GetPhoto(PhotoSize size)
    {
        //string path = HttpContext.Current.Server.MapPath("~/Images/");
        string path = HttpContext.Current.Server.MapPath("~/public/std/");
        switch (size)
        {
            case PhotoSize.Small:
                path += "placeholder-100.png";
                //path += "placeholder-100.png";
                break;
            case PhotoSize.Medium:
                path += "placeholder-100.png";
                //path += "placeholder-100.png";
                break;
            case PhotoSize.Large:
                path += "placeholder-100.png";
                //path += "placeholder-100.png";
                break;
            default:
                path += "placeholder-100.png";
                //path += "placeholder-100.png";
                break;
        }
        return new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read);
    }

    public static Stream GetFirstPhotobyPos(int albumid, PhotoSize size)
    {
        DataSetVepAdminTableAdapters.PhotosTableAdapter taPhotos = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
        DataTable dtPhotos = taPhotos.GetFirstPhotoByPos(albumid);
         
       
        try
        {
            object result = dtPhotos.Rows[0]["BytesOriginal"];
            return new MemoryStream((byte[])result);
        }
        catch
        {
            return null;
        }
    
    }


    public static Stream GetFirstPhoto(int albumid, PhotoSize size)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("GetFirstPhoto", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AlbumID", albumid));
                command.Parameters.Add(new SqlParameter("@Size", (int)size));
                bool filter = !(HttpContext.Current.User.IsInRole("Friends") || HttpContext.Current.User.IsInRole("Administrators"));
                command.Parameters.Add(new SqlParameter("@IsPublic", filter));
                connection.Open();
                object result = command.ExecuteScalar();
                try
                {
                    return new MemoryStream((byte[])result);
                }
                catch
                {
                    return null;
                }
            }
        }
    }

    public static List<Photo> GetPhotos(int AlbumID)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("GetPhotos", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AlbumID", AlbumID));
                bool filter = !(HttpContext.Current.User.IsInRole("Friends") || HttpContext.Current.User.IsInRole("Administrators"));
                command.Parameters.Add(new SqlParameter("@IsPublic", filter));
                connection.Open();
                List<Photo> list = new List<Photo>();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Photo temp = new Photo(
                            (int)reader["PhotoID"],
                            (int)reader["AlbumID"],                          
                            (string)reader["Caption"],
                            (int)reader["ordine"]);
                        list.Add(temp);
                    }
                }
                return list;
            }
        }
    }

    public static List<Photo> GetPhotos()
    {
        return GetPhotos(GetRandomAlbumID());
    }

    public static void AddPhoto(int AlbumID, string Caption, byte[] BytesOriginal,int ordine)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("AddPhoto", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AlbumID", AlbumID));
                command.Parameters.Add(new SqlParameter("@Caption", Caption));
                command.Parameters.Add(new SqlParameter("@BytesOriginal", BytesOriginal));
                command.Parameters.Add(new SqlParameter("@BytesFull", ResizeImageFile(BytesOriginal, 600)));
                command.Parameters.Add(new SqlParameter("@BytesPoster", ResizeImageFile(BytesOriginal, 198)));
                command.Parameters.Add(new SqlParameter("@BytesThumb", ResizeImageFile(BytesOriginal, 100)));
                command.Parameters.Add(new SqlParameter("@Photo_Ordine",ordine ));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }


    public static void AddPhotoMultiLingue(int AlbumID, string Caption, byte[] BytesOriginal, int ordine,string CaptionEN,string CaptionDE)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("AddPhotoML", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AlbumID", AlbumID));
                command.Parameters.Add(new SqlParameter("@Caption", Caption));
                command.Parameters.Add(new SqlParameter("@BytesOriginal", BytesOriginal));
                command.Parameters.Add(new SqlParameter("@BytesFull", ResizeImageFile(BytesOriginal, 600)));
                command.Parameters.Add(new SqlParameter("@BytesPoster", ResizeImageFile(BytesOriginal, 198)));
                command.Parameters.Add(new SqlParameter("@BytesThumb", ResizeImageFile(BytesOriginal, 100)));
                command.Parameters.Add(new SqlParameter("@Photo_Ordine", ordine));
                command.Parameters.Add(new SqlParameter("@CaptionEN", CaptionEN));
                command.Parameters.Add(new SqlParameter("@CaptionDE", CaptionDE));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }


    // funzione per cancellare tutte le foto di un album
    public static void RemovePhoto(int PhotoID)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("RemovePhoto", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PhotoID", PhotoID));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    public static void EditPhoto(string Caption, int PhotoID)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("EditPhoto", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@Caption", Caption));
                command.Parameters.Add(new SqlParameter("@PhotoID", PhotoID));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    // Metodi relativi agli album
    public static List<Album> GetAlbums()
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("GetAlbums", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                bool filter = !(HttpContext.Current.User.IsInRole("Friends") || HttpContext.Current.User.IsInRole("Administrators"));
                command.Parameters.Add(new SqlParameter("@IsPublic", filter));
                connection.Open();
                List<Album> list = new List<Album>();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Album temp = new Album(
                            (int)reader["AlbumID"],
                            (int)reader["NumberOfPhotos"],
                            (string)reader["Caption"],
                            (bool)reader["IsPublic"],
                            (int)reader["TipoAlbum"]);
                        list.Add(temp);
                    }
                }
                return list;
            }
        }
    }

    public static List<Album> GetAlbumByTipo(int tipo)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("GetAlbumByTipo", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                bool filter = !(HttpContext.Current.User.IsInRole("Friends") || HttpContext.Current.User.IsInRole("Administrators"));
                command.Parameters.Add(new SqlParameter("@IsPublic", filter));
                command.Parameters.Add(new SqlParameter("@TipoAlbum", tipo));
                connection.Open();
                List<Album> list = new List<Album>();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Album temp = new Album(
                            (int)reader["AlbumID"],
                            (int)reader["NumberOfPhotos"],
                            (string)reader["Caption"],
                            (bool)reader["IsPublic"],
                            (int)reader["TipoAlbum"]);
                        list.Add(temp);
                    }
                }
                return list;
            }
        }
    }

    public static void AddAlbum(string Caption, int TipoAlbum)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("AddAlbum", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@Caption", Caption));
                command.Parameters.Add(new SqlParameter("@IsPublic", true));
                command.Parameters.Add(new SqlParameter("@TipoAlbum", TipoAlbum));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    public static void RemoveAlbum(int AlbumID)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("RemoveAlbum", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AlbumID", AlbumID));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    public static void EditAlbum(string Caption, bool IsPublic, int AlbumID)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("EditAlbum", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@Caption", Caption));
                command.Parameters.Add(new SqlParameter("@IsPublic", IsPublic));
                command.Parameters.Add(new SqlParameter("@AlbumID", AlbumID));
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    public static int GetFotoCount(int AlbumID)
    {
        DataSetVepAdminTableAdapters.PhotosTableAdapter taAlb = new DataSetVepAdminTableAdapters.PhotosTableAdapter();
        DataTable dtFoto = taAlb.GetFotoByAlbumID(AlbumID);

        return dtFoto.Rows.Count;
    }

    public static string GetNomeAlbum(int AlbumID)
    {
        //   System.Collections.Specialized.NameValueCollection coll;
        // coll = HttpUtility.ParseQueryString("AlbumID");

        string nomeAlbume = "";
        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlb = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtInfoAlb = taAlb.GetInfoAlbumbyID(AlbumID);

        nomeAlbume = dtInfoAlb.Rows[0]["Caption"].ToString();
        return nomeAlbume;
    }

    public static string GetNomeAlbum_join(int AlbumID)
    {
        //   System.Collections.Specialized.NameValueCollection coll;
        // coll = HttpUtility.ParseQueryString("AlbumID");

        string nomeAlbume = "";
        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlb = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtInfoAlb = taAlb.GetInfoAlbumbyID_j(AlbumID);

        nomeAlbume = dtInfoAlb.Rows[0]["Titolo"].ToString();
        return nomeAlbume;
    }





    public static bool isNewsLinked(int News_ID)
    {
        bool isLink = false;

        DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlb = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
        DataTable dtAlb = taAlb.GetIdAlbum(News_ID);
        if (dtAlb.Rows.Count != 0)
        {
            isLink = true;
        }
        return isLink;
    }

    //public static bool isNewsLinked(int AlbumID)
    //{
    //    bool isLink = false;

    //    DataSetVepAdminTableAdapters.AlbumsTableAdapter taAlb = new DataSetVepAdminTableAdapters.AlbumsTableAdapter();
    //    DataTable dtAlb = taAlb.GetInfoAlbumbyID(AlbumID);
    //    //if (!string.IsNullOrEmpty(dtAlb.Rows[0]["NewsEventoID"].ToString()))
    //    //{
    //    //    isLink = true;

    //    //}

    //    return isLink;

    //}

    public static int GetRandomAlbumID()
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("GetNonEmptyAlbums", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                connection.Open();
                List<Album> list = new List<Album>();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Album temp = new Album((int)reader["AlbumID"], 0, "", false, 0);
                        list.Add(temp);
                    }
                }
                try
                {
                    Random r = new Random();
                    return list[r.Next(list.Count)].AlbumID;
                }
                catch
                {
                    return -1;
                }
            }
        }
    }

    public static MemoryStream MyResizeImageFilePathP(string pathFile, byte[] imageByte, int targetWidth, int targetHeight)
    {
        // Impostare le opzioni di risposta
        HttpContext.Current.Response.ContentType = "image/jpeg";
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Public);
        HttpContext.Current.Response.BufferOutput = false;

        MemoryStream mImage;
        if (!string.IsNullOrEmpty(pathFile))
        {
            string path = "";
            string filePath = "";
            if (pathFile == "~\\")
            {
                path = "~\\images/";
                filePath = HttpContext.Current.Server.MapPath(path) + "standard.jpg";
            }
            else
            {
                path = pathFile.Replace(Path.GetFileName(pathFile), "");
                filePath = HttpContext.Current.Server.MapPath(path) + Path.GetFileName(pathFile);
            }

            FileStream imageFile = new FileStream(filePath, FileMode.Open);
            int buffersize = (int)imageFile.Length;

            byte[] imageFileByte = new byte[buffersize];

            imageFile.Read(imageFileByte, 0, buffersize);
            imageFile.Close();
            mImage = new MemoryStream(imageFileByte);
        }
        else
        {
            mImage = new MemoryStream(imageByte);
        }

        using (System.Drawing.Image oldImage = System.Drawing.Image.FromStream(mImage))
        {
            Size newSize = MyCalculateDimensions_(oldImage.Size, targetWidth, targetHeight);
            using (Bitmap newImage = new Bitmap(newSize.Width, newSize.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    /* canvas.SmoothingMode = SmoothingMode.AntiAlias;
                     canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                     canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;*/
                    canvas.DrawImage(oldImage, new Rectangle(new Point(0, 0), newSize));
                    MemoryStream m = new MemoryStream();

                    newImage.Save(m, ImageFormat.Jpeg);

                    return m;
                }
            }
        }
    }

    public static MemoryStream MyResizeImageFile(string pathFile, byte[] imageByte, int targetWidth, int targetHeight)
    {
        // Impostare le opzioni di risposta
        HttpContext.Current.Response.ContentType = "image/jpeg";
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Public);
        HttpContext.Current.Response.BufferOutput = false;

        MemoryStream mImage;
        if (!string.IsNullOrEmpty(pathFile))
        {
            string path = "";
            string filePath = "";
            if (pathFile == "~\\")
            {
                path = "~\\images/";
                filePath = HttpContext.Current.Server.MapPath(path) + "standard.jpg";
            }
            else
            {
                path = pathFile.Replace(Path.GetFileName(pathFile), "");
                filePath = HttpContext.Current.Server.MapPath(path) + Path.GetFileName(pathFile);
            }

            FileStream imageFile = new FileStream(filePath, FileMode.Open);
            int buffersize = (int)imageFile.Length;

            byte[] imageFileByte = new byte[buffersize];

            imageFile.Read(imageFileByte, 0, buffersize);
            imageFile.Close();
            mImage = new MemoryStream(imageFileByte);
        }
        else
        {
            mImage = new MemoryStream(imageByte);
        }

        using (System.Drawing.Image oldImage = System.Drawing.Image.FromStream(mImage))
        {
            Size newSize = MyCalculateDimensions(oldImage.Size, targetWidth, targetHeight);
            using (Bitmap newImage = new Bitmap(newSize.Width, newSize.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                   /* canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;*/
                     
                    canvas.DrawImage(oldImage, new Rectangle(new Point(0, 0), newSize));
                    MemoryStream m = new MemoryStream();

                    newImage.Save(m, ImageFormat.Jpeg);

                    return m;
                }
            }
        }
    }

    private static Size MyCalculateDimensions(Size oldSize, int targetWidth, int targetHeight)
    {
        Size newSize = new Size();
        int width = oldSize.Width;
        int height = oldSize.Height;
        int mWidth = targetWidth;
        int mHeight = targetHeight;

        bool doWidthResize = (mWidth > 0 && width > mWidth && width > mHeight);
        bool doHeightResize = (mHeight > 0 && height > mHeight && height > mWidth);

        //only resize if the image is bigger than the max
        if (doWidthResize || doHeightResize)
        {
            int iStart;
            Decimal divider;
            if (doWidthResize)
            {
                iStart = width;
                divider = Math.Abs((Decimal)iStart / (Decimal)mWidth);
                width = mWidth;
                height = (int)Math.Round((Decimal)(height / divider));
                // controllo l'altezza
                if (height < targetHeight)
                {
                    iStart = height;
                    divider = Math.Abs((Decimal)iStart / (Decimal)mHeight);
                    height = mHeight;
                    width = (int)Math.Round((Decimal)(width / divider));
                }
            }
            else
            {
                iStart = height;
                divider = Math.Abs((Decimal)iStart / (Decimal)mHeight);
                height = mHeight;
                width = (int)Math.Round((Decimal)(width / divider));
                if (width < targetWidth)
                {
                    iStart = width;
                    divider = Math.Abs((Decimal)iStart / (Decimal)mWidth);
                    width = mWidth;
                    height = (int)Math.Round((Decimal)(height / divider));
                }
            }
        }
        newSize.Width = width;
        newSize.Height = height;

        return newSize;
    }

    private static Size MyCalculateDimensions_(Size oldSize, int targetWidth, int targetHeight)
    {
        Size newSize = new Size();

        if (oldSize.Height > oldSize.Width) //orientamento verticale
        {
            //ridimensiono in proporzione rispetto alla larghezza
            newSize.Width = targetWidth;
            newSize.Height = (int)(oldSize.Height * ((float)targetWidth / (float)oldSize.Width));

            //if (newSize.Height < targetHeight) // controllo la nuova altezza calcolata
            //    // ridimensiono rispetto all'altezza 
            //    newSize.Height = targetHeight;
        }
        else //orientamento orizzontale
        {
            //ridimensiono in proporzione rispetto alla larghezza
            newSize.Width = targetWidth;
            newSize.Height = (int)(oldSize.Height * ((float)targetWidth / (float)oldSize.Width));
            if (newSize.Height < targetHeight) // controllo la nuova altezza calcolata
            {
                newSize.Height = targetHeight;
                newSize.Height = (int)(oldSize.Height * ((float)targetWidth / (float)oldSize.Width));
            }
        }

        //if (oldSize.Height > oldSize.Width) //orientamento verticale
        //{
        //    newSize.Width = targetWidth;
        //    newSize.Height = (int)(oldSize.Height * ((float)targetWidth / (float)oldSize.Width));
        //}
        //else //orientamento orizzontale
        //{
        //    newSize.Width = targetWidth;
        //    newSize.Height = (int)(oldSize.Height * ((float)targetWidth / (float)oldSize.Width));
        //}
        return newSize;
    }

    // Funzioni di supporto
    private static byte[] ResizeImageFile(byte[] imageFile, int targetSize)
    {
        using (System.Drawing.Image oldImage = System.Drawing.Image.FromStream(new MemoryStream(imageFile)))
        {
            Size newSize = CalculateDimensions(oldImage.Size, targetSize);
            using (Bitmap newImage = new Bitmap(newSize.Width, newSize.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    canvas.DrawImage(oldImage, new Rectangle(new Point(0, 0), newSize));
                    MemoryStream m = new MemoryStream();
                    newImage.Save(m, ImageFormat.Jpeg);
                    return m.GetBuffer();
                }
            }
        }
    }


    public static MemoryStream ResizeImageFileP(byte[] imageByte, int targetWidth, int targetHeight)
    {


        // Impostare le opzioni di risposta
        HttpContext.Current.Response.ContentType = "image/jpeg";
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Public);
        HttpContext.Current.Response.BufferOutput = false;


        MemoryStream mImage;

        mImage = new MemoryStream(imageByte);


        using (System.Drawing.Image oldImage = System.Drawing.Image.FromStream(mImage))
        {
            Size newSize = MyCalculateDimensions_(oldImage.Size, targetWidth, targetHeight);
            using (Bitmap newImage = new Bitmap(newSize.Width, newSize.Height, PixelFormat.Format24bppRgb))
            {
                using (Graphics canvas = Graphics.FromImage(newImage))
                {
                    canvas.SmoothingMode = SmoothingMode.AntiAlias;
                    canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    canvas.DrawImage(oldImage, new Rectangle(new Point(0, 0), newSize));
                    MemoryStream m = new MemoryStream();

                    newImage.Save(m, ImageFormat.Jpeg);


                    return m;


                }
            }
        }
    }

    private static Size CalculateDimensions(Size oldSize, int targetSize)
    {
        Size newSize = new Size();
        if (oldSize.Height > oldSize.Width)
        {
            newSize.Width = (int)(oldSize.Width * ((float)targetSize / (float)oldSize.Height));
            newSize.Height = targetSize;
        }
        else
        {
            newSize.Width = targetSize;
            newSize.Height = (int)(oldSize.Height * ((float)targetSize / (float)oldSize.Width));
        }
        return newSize;
    }

    public static ICollection ListUploadDirectory()
    {
        DirectoryInfo d = new DirectoryInfo(System.Web.HttpContext.Current.Server.MapPath("~/Upload"));
        return d.GetFileSystemInfos("*.jpg");
    }
}