package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {

	public static void main(String[] args) 
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
			String IDart = "2";
			ResultSet rs = kom.executeQuery(String.format("CALL dajArtikal(%s)", IDart));
			for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++)
			{
				System.out.println("Kolona " + rs.getMetaData().getColumnName(i)
									+ " je tipa " + rs.getMetaData().getColumnTypeName(i));
			}
			
			while (rs.next())
			{
				System.out.println(rs.getString("Naziv"));
			}
			
							
			nasaKonekcija.close();
		} catch (SQLException joj)
		{
			joj.printStackTrace();
		}
	}

}
