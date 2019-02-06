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
	
	public static void probnaKonekcija() 
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) 
		{
			e.printStackTrace();
		} 
		
		try
		{
			Connection nasaKonekcija = DriverManager.getConnection("jdbc:mysql://localhost", "javaTest", "NekaSifra");
			Statement kom = nasaKonekcija.createStatement();
			kom.executeQuery("USE pos");
			ResultSet rs = kom.executeQuery("SELECT * FROM racun");
			
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

}
