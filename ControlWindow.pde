import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// TODO Better UI

class ControlWindow {
  
  JFrame f;
  JPanel p;
  JTextArea codeArea;
  JTextField inputArea, outputArea;
  JButton clean, run;
  
  void updateOutput() {
    if (output == null) {
      outputArea.setText("");
    } else {
      // TODO Framerate restrictions here
      outputArea.setText(output.toString());
    }
  }
  
  JTextArea mkCodeArea() {
    codeArea = new JTextArea(",[.,]", 20, 30);
    codeArea.setFont(new Font("monospaced", Font.PLAIN, 12));
    return codeArea;
  }
  
  JTextField mkInputArea() {
    return inputArea = new JTextField("hello");
  }
  
  JTextField mkOutputArea() {
    return outputArea = new JTextField("");
  }
  
  JButton mkRunBtn() {
    run = new JButton("Run");
    run.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        String source = codeArea.getText();
        String input = inputArea.getText();
        runProgram(source, input);
      }
    });
    return run;
  }
  
  JButton mkCleanBtn() {
    clean = new JButton("Clean");
    clean.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        cleanup();
      }
    });
    return clean;
  }
  
  JPanel mkButtons() {
    JPanel p = new JPanel();
    p.setLayout(new FlowLayout());
    
    p.add(mkCleanBtn());
    p.add(mkRunBtn());
    
    return p;
  }
  
  JPanel mkIOGrid() {
    JPanel grid = new JPanel();
    grid.setLayout(new GridBagLayout());
    GridBagConstraints wtf;
    
    wtf = new GridBagConstraints();
    wtf.gridx = 0; wtf.gridy = 0;
    grid.add(new JLabel("Input"), wtf);
    
    wtf = new GridBagConstraints();
    wtf.fill = GridBagConstraints.HORIZONTAL;
    wtf.gridx = 1; wtf.gridy = 0;
    wtf.weightx = 1;
    grid.add(mkInputArea(), wtf);
    
    wtf = new GridBagConstraints();
    wtf.gridx = 0; wtf.gridy = 1;
    grid.add(new JLabel("Output"), wtf);
    
    wtf = new GridBagConstraints();
    wtf.fill = GridBagConstraints.HORIZONTAL;
    wtf.gridx = 1; wtf.gridy = 1;
    wtf.weightx = 1;
    grid.add(mkOutputArea(), wtf);
    outputArea.setEditable(false);
    
    return grid;
  }
  
  ControlWindow() {
    f = new JFrame("BrainFuck Controls");
    p = new JPanel();
    p.setLayout(new GridBagLayout());
    
    GridBagConstraints wtf;
    
    wtf = new GridBagConstraints();
    wtf.fill = GridBagConstraints.BOTH;
    wtf.weightx = 1; wtf.weighty = 1;
    wtf.gridx = 0; wtf.gridy = 0;
    p.add(mkCodeArea(), wtf);
    
    wtf = new GridBagConstraints();
    wtf.fill = GridBagConstraints.HORIZONTAL;
    wtf.weightx = 1;
    wtf.gridx = 0; wtf.gridy = 1;
    p.add(mkIOGrid(), wtf);
    
    wtf = new GridBagConstraints();
    wtf.weightx = 1;
    wtf.gridx = 0; wtf.gridy = 2;
    p.add(mkButtons(), wtf);
    
    f.add(p);
    f.pack();
    f.setVisible(true);
  }
  
}