package test;

import java.awt.EventQueue;
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.ListSelectionModel;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class MainWindow {

	private JFrame frame;
	private JTable tabela;

	public static void main(String[] args) 
	{
		MainWindow window = new MainWindow();
		window.frame.setVisible(true);
	}

	public MainWindow() 
	{
		initialize();
	}

	private void initialize() 
	{
		frame = new JFrame();
		frame.setBounds(100, 100, 450, 300);
		frame.setLocationRelativeTo(null);
		frame.setTitle("SQL i JAVA :)");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JPanel panel = new JPanel();
		frame.getContentPane().add(panel, BorderLayout.NORTH);
		
		JButton btnObrisi = new JButton("Obrisi");
		btnObrisi.addActionListener(new ActionListener() 
		{
			public void actionPerformed(ActionEvent arg0) 
			{
				if (tabela.getSelectedRowCount() == 1)
				{
					
					Comm.obrisiRed("artikal", tabela.getModel().getValueAt(tabela.getSelectedRow(), 0).toString());
					tabela.setModel(ucitajPodatke());
				}
			}
		});
		panel.add(btnObrisi);
		
		JScrollPane scrollPane = new JScrollPane();
		frame.getContentPane().add(scrollPane, BorderLayout.CENTER);
		
		tabela = new JTable();
		tabela.setDefaultEditor(Object.class, null);
		tabela.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		tabela.setModel(ucitajPodatke());
		
		//Rucni rad :) 
		/*podaci.addColumn("Test kolona");
		podaci.addColumn("Druga kolona");
		String[] red = {"Prvi", "Red"};
		podaci.addRow(red);
		Vector<String> redV = new Vector<String>();
		redV.add("Drugi");
		redV.add("Red");
		podaci.addRow(redV);*/
		
		
		scrollPane.setViewportView(tabela);	
	}
	
	public DefaultTableModel ucitajPodatke()
	{
		DefaultTableModel podaci = new DefaultTableModel();
		Comm.dajPodatke();
		
		for (int i = 0; i < Comm.naziviKolona.length; i++)
		{
			podaci.addColumn(Comm.naziviKolona[i]);
		}
		
		for (String[] red: Comm.sviRedovi)
		{
			podaci.addRow(red);
		}
		
		return podaci;
	}
}
