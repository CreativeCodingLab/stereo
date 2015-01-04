stereo
======

Stereographic library for Processing 2.2.1 (see the branches that work with previous versions of Processing), based on code by Paul Bourke. This port to Processing was originally created by Charlie Roberts and Angus Forbes. It continues to be maintained by Angus Forbes. Javier Villegas fixed a number of bugs and helped port examples to Processing 2.0. Massimo De Marchi and Giorgio Conte created examples that work with Processing 2.2.1. Many thanks to Andres Colubri for resolving some of the issues introduced in Processing 2.0 (and now resolved in 2.2.1).

This 2.2.1 version of the library gives you more flexibility in setting the convergence and eye separation. The 2.2.1 gives you access to the JOGL "capabilities", so we can set up an active stereo context (as we can in 1.5.1, but couldn't in 2.0). However, the drivers for Nvidia's consumer level active stereo systems have issues with OpenGL. (A work around might be found at https://github.com/tliron/opengl-3d-vision-bridge, but we haven't had a chance to incorporate it.) So, if you are planning on using this library for active stereo, the only one that has been explicitly tested by us is the 1.5.1 branch. In the meantime, anaglyph and passive work great, and we've created some simple examples to demonstrate them.

Feel free to send me an email at angus.forbes (at) gmail if you have questions, or especially if you have some demo code that uses this library.

Projects that use (or have used) this library:

ICA Temporal Brain-Activity Viewer, University of Arizona Speech and Hearing Lab

SCRAPE (SCReen Adjusted Panoramic Effect) : https://github.com/c-flynn/SCRAPE

Allosphere Research Facility : http://www.allosphere.ucsb.edu/

Annular Genealogy art project : http://vimeo.com/43759229

Philip Galanter's 3D Interactive Wall : http://philipgalanter.com/

Emanuel Haas's Dance of Molecules : http://www.behance.net/gallery/Dance-of-Molecules/11614101


