# Comp-App-Final-Project
Title: Quantifying the Proliferation of 3D Cultured Cells in 2d

Program that can estimate the proliferation of 3D cultured cells based on their 2D images and more accurately estimate number of cells on 3D scaffold. The program reads different 2D-imaged 3D culture systems of a starch hydrogel system. By using threshold RGB based detection and edge detection the program outputs the percent survival of cells and estimates the actual number of cells on the scaffold. 

This code is built to read the files provided in the repository which are different images of live-dead staining and cell tracker starch hydrogel images.

The user should input the image name and if it is either cell tracker or live-dead staining for the code to run properly.

For guidance on how to distinguish if it is live-dead staining or cell tracker:
Live-dead staining:Starch hydrogel images where cells are stained with live-dead staining. Yellow-orange color represents the live cells.
Cell tracker: Starch hydrogel images where cells are stained with red fluorescent tracker. No distinction between dead and live cells.

Sample input/output:

<img width="549" alt="Sample input:output" src="https://user-images.githubusercontent.com/94568660/145754397-1273717b-a695-4454-acaa-8119058802f0.png">
