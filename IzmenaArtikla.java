package test;

import java.awt.BorderLayout;
import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.JLabel;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

public class IzmenaArtikla extends JDialog {

	private final JPanel contentPanel = new JPanel();
	private JTextField txtNaziv;
	private JTextField txtLager;
	private JTextField txtUlazna;
	private JTextField txtMarza;
	private JTextField txtPorez;
	
	public IzmenaArtikla(String PK) {
		setBounds(100, 100, 450, 300);
		getContentPane().setLayout(new BorderLayout());
		contentPanel.setBorder(new EmptyBorder(5, 5, 5, 5));
		getContentPane().add(contentPanel, BorderLayout.CENTER);
		contentPanel.setLayout(null);
		
		txtNaziv = new JTextField();
		txtNaziv.setBounds(132, 24, 86, 20);
		contentPanel.add(txtNaziv);
		txtNaziv.setColumns(10);
		
		txtLager = new JTextField();
		txtLager.setBounds(132, 60, 86, 20);
		contentPanel.add(txtLager);
		txtLager.setColumns(10);
		
		txtUlazna = new JTextField();
		txtUlazna.setBounds(132, 101, 86, 20);
		contentPanel.add(txtUlazna);
		txtUlazna.setColumns(10);
		
		txtMarza = new JTextField();
		txtMarza.setBounds(132, 132, 86, 20);
		contentPanel.add(txtMarza);
		txtMarza.setColumns(10);
		
		txtPorez = new JTextField();
		txtPorez.setBounds(132, 172, 86, 20);
		contentPanel.add(txtPorez);
		txtPorez.setColumns(10);
		
		JLabel lblNewLabel = new JLabel("%");
		lblNewLabel.setBounds(228, 175, 46, 14);
		contentPanel.add(lblNewLabel);
		
		JLabel label = new JLabel("%");
		label.setBounds(228, 135, 46, 14);
		contentPanel.add(label);
		
		JLabel lblNewLabel_1 = new JLabel("Naziv artikla:");
		lblNewLabel_1.setBounds(22, 27, 100, 14);
		contentPanel.add(lblNewLabel_1);
		
		JLabel lblLager = new JLabel("Lager:");
		lblLager.setBounds(22, 63, 100, 14);
		contentPanel.add(lblLager);
		
		JLabel lblUlaznaCena = new JLabel("Ulazna cena:");
		lblUlaznaCena.setBounds(22, 104, 100, 14);
		contentPanel.add(lblUlaznaCena);
		
		JLabel lblMarza = new JLabel("Marza:");
		lblMarza.setBounds(22, 135, 100, 14);
		contentPanel.add(lblMarza);
		
		JLabel lblPorez = new JLabel("Porez:");
		lblPorez.setBounds(22, 175, 100, 14);
		contentPanel.add(lblPorez);
		{
			JPanel buttonPane = new JPanel();
			buttonPane.setLayout(new FlowLayout(FlowLayout.RIGHT));
			getContentPane().add(buttonPane, BorderLayout.SOUTH);
			{
				JButton okButton = new JButton("OK");
				okButton.addActionListener(new ActionListener() {
					public void actionPerformed(ActionEvent e) 
					{
						Comm.izmenaArtikla(txtNaziv.getText(), txtLager.getText(), 
								         txtUlazna.getText(), txtMarza.getText(), 
								         txtPorez.getText());
						dispose();
					}
				});
				okButton.setActionCommand("OK");
				buttonPane.add(okButton);
				getRootPane().setDefaultButton(okButton);
			}
			{
				JButton cancelButton = new JButton("Cancel");
				cancelButton.addActionListener(new ActionListener() {
					public void actionPerformed(ActionEvent e) 
					{
						dispose();
					}
				});
				cancelButton.setActionCommand("Cancel");
				buttonPane.add(cancelButton);
			}
		}
	}
}
