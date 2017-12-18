//as imaxes
PImage img00, img01;

void show_about_us() {
  
   textSize(16);
   fill(white_color);

   img00=loadImage("logo_wg.jpg");
   img01=loadImage("logo_bdunk.jpg");

   image(img00, 170, 60, 190, 35);
   image(img01, 170, 120, 175, 75);
 
   text(l_text_about_us[lang], 170, 220); 
    
}
