package test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class Comm {

	public static String[] naziviKolona;
	public static Vector<String[]> sviRedovi = new Vector<String[]>();
	
	private static Connection nasaKonekcija  = null;
	private static Statement kom = null;
	
	public static void ozbiljnaKonekcija()
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			Connection nasaKonekcija = DriverManager.getConnection("jdbc:mysql://localhost", "javaTest", "NekaSifra");
			kom = nasaKonekcija.createStatement();
			kom.executeQuery("USE pos");
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException | SQLException e) 
		{
			e.printStackTrace();
		} 
	}
	
	public static void dajPodatke() 
	{
		ozbiljnaKonekcija();
		sviRedovi.clear();
		try
		{	
			ResultSet rs = kom.executeQuery("SELECT Naziv, Lager FROM artikal");	
			int brojKolona = rs.getMetaData().getColumnCount();
			naziviKolona = new String[brojKolona];
			for (int i = 1; i <= brojKolona; i++)
			{
				naziviKolona[i-1] = rs.getMetaData().getColumnName(i);
			}
			
			while (rs.next())
			{     
				String[] red = new String[brojKolona];
				for (int i = 1; i <= brojKolona; i++)
				{
					red[i-1] = rs.getString(i);
				}
				
				sviRedovi.add(red);
			}		
			nasaKonekcija.close();
		} catch (SQLException joj)
		{
			joj.printStackTrace();
		}
	}
	
	public static int obrisiRed(String tip, String IDreda)
	{
		ozbiljnaKonekcija();
		try 
		{
			//Nesto nesto nesto
			nasaKonekcija.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return 0;
	}

}
