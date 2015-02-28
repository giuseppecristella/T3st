public class Photo {

	private int _id;
	private int _albumid;
	private string _caption;
    private int _ordine;

    public int PhotoID { get { return _id; } }
	public int AlbumID { get { return _albumid; } }
	public string Caption { get { return _caption; } }
    public int ordine { get { return _ordine; } }

	public Photo(int id, int albumid, string caption, int ordine) {
		_id = id;
		_albumid = albumid;
		_caption = caption;
        _ordine = ordine;
	}

}