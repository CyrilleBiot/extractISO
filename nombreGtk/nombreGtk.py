#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# ====================================================
#      Dépendances DEBIAN :  python3-vlc, python3-gi
# ====================================================
import random, vlc, time
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class nbGtk(Gtk.Window):

    def __init__(self):
        #self.mini = int(input('Limite inf : '))
        #self.maxi = int(input('Limite sup : '))

        Gtk.Window.__init__(self, title="Nombres")
        self.set_resizable(True)
        #self.set_icon_from_file(self.dirBase+"apropos.png")
        self.set_border_width(10)
        self.set_name('fieldset')

        #
        # Creation de la grille
        grid = Gtk.Grid()
        grid.set_column_homogeneous(False)
        grid.set_column_spacing(6)
        grid.set_row_spacing(6)
        grid.set_row_homogeneous(False)

        # other buttons.
        # a new radiobutton with a label
        label_plage = Gtk.Label(label='Plage : ')
        grid.attach(label_plage,0,0,1,1)

        button_plage = Gtk.RadioButton(label="0-10")
        button_plage.connect("toggled", self.toggled)
        grid.attach(button_plage, 1, 0, 1, 1)

        possibilities = ['20-30', '30-40', '40-50', '50-60', '60-70', '70-80', '80-90', '90-100',
                         '60-80', '80-100']
        button_plages = [0] * len(possibilities)
        nb_lignes_grid2 = len(possibilities) + 3

        for i in range(len(possibilities)):
            # another radiobutton, in the same group as button1
            button_plages[i] = Gtk.RadioButton.new_from_widget(button_plage)
            button_plages[i].set_label(possibilities[i])
            button_plages[i].connect("toggled", self.toggled)
            button_plages[i].set_active(False)
            # attach the button
            grid.attach(button_plages[i], i + 3,0,1,1)



        label_nombre = Gtk.Label(label="Nombre : ")
        grid.attach(label_nombre, 0,1,1,1)







        self.add(grid)





    def toggled(self, button):
        self.plage = button.get_label()
        print(self.plage)





    def cherche_nombre(self):
       nb_hasard = (random.choice(range(self.mini, self.maxi)))
       # debug
       print(self.mini, '-', self.maxi, '-', nb_hasard)
       son = vlc.MediaPlayer("./nb-mp3/" + str(nb_hasard) + ".mp3")
       son.play()
       time.sleep(1) # Nécessaire sinon pas de son...

       reponse = int(input("Ecriture lettrée : "))

       if reponse == nb_hasard:
          return(True)
       else:
          return(False)


def main():
    """
    La boucle de lancement
    :return:
    """
    win = nbGtk()
    #print(win.cherche_nombre())
    #win.gtk_style()
    win.connect("destroy", Gtk.main_quit)
    win.move(10, 10)
    win.show_all()
    Gtk.main()

"""
 Boucle main()
"""
if __name__ == "__main__":
    # execute only if run as a script
    main()
