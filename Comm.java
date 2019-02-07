package test;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class Comm {

	public static String[] naziviKolona;
	public static Vector<String[]> sviRedovi = new Vector<String[]>();
	public static Vector<String[]> PK = new Vector<String[]>();
	
	private static Connection nasaKonekcija  = null;
	private static Statement kom = null;
	
	public static void ozbiljnaKonekcija()
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			nasaKonekcija = DriverManager.getConnection("jdbc:mysql://localhost", "javaTest", "NekaSifra");
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
			ResultSet rs = kom.executeQuery("SELECT * FROM artikal");	
			int brojKolona = rs.getMetaData().getColumnCount();
			naziviKolona = new String[brojKolona];
			for (int i = 1; i <= brojKolona; i++)
			{
				naziviKolona[i-1] = rs.getMetaData().getColumnName(i);
			}
			
			DatabaseMetaData dbmd = nasaKonekcija.getMetaData();
			ResultSet primarni = dbmd.getPrimaryKeys(null, rs.getMetaData().getSchemaName(1), rs.getMetaData().getTableName(1));
			
			Vector<String> PKkolone = new Vector<String>();
			while (primarni.next())
			{
				if (!PKkolone.contains(primarni.getString("COLUMN_NAME")))
				{
					PKkolone.add(primarni.getString("COLUMN_NAME"));
				}
			}
			
			while (rs.next())
			{     
				String[] red = new String[brojKolona];
				String[] PKzaRed = new String[PKkolone.size()];
				for (int i = 1; i <= brojKolona; i++)
				{
					red[i-1] = rs.getString(i);
					if (PKkolone.contains(rs.getMetaData().getColumnName(i)))
					{
						PKzaRed[PKkolone.indexOf(rs.getMetaData().getColumnName(i))] = rs.getString(i);
					}
				}

				PK.add(PKzaRed);
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
			ResultSet rs = kom.executeQuery(String.format("CALL obrisiRed('%s', '%s')", IDreda, tip));
			nasaKonekcija.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return 0;
	}
	
	public static void izmenaArtikla(String naziv, String lager, String ulazna,
			                       String marza, String porez)
	{
		ozbiljnaKonekcija();
		try
		{
			kom.executeQuery(String.format("CALL izmenaArtikla('%s', '%s', '%s', '%s', '%s')",
					                        naziv, lager, ulazna, marza, porez));
			nasaKonekcija.close();
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

}
