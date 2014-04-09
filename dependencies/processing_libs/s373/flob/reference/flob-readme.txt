/* 

flob // flood-fill multi-blob detector 
(c) copyright 2009 andré sier

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General
Public License along with this library; if not, write to the
Free Software Foundation, Inc., 59 Temple Place, Suite 330,
Boston, MA  02111-1307  USA

*/

package s373.flob;
usage: import s373.flob.*; etc..
contact: andré sier <mail@s373.net>
url: http://s373.net/code/flob
s373.flob.* is a s373 open source lgpl code product


------------
flob history
------------

updates001l // 20090722: 
- sweet lumauser mode in binarize;
- core binarize stage now calcs with different colormodes: red, green, blue, luma601, luma709;
- blob quads for simple perspective;

updates001k // 20090621: 
- get and set functions for all core parameters
- unified core algorithms as: calc, calcsimple, track, tracksimple
- features tracking (for now: armleft(xy),armright(xy),footleft(xy),footright(xy))
(feature tracking based on code from a-jit.human in 747.3)

updates001k // 20090521: 
- features tracking (arms, head, bottom)
- fastblur code by mario klingemann optionally inserted in binarize stage
- improved javadoc's (reference)
- fixed tracking code
- fixed bogus empty first videomode
- getTrackedBlob now returns a trackedBlob type
- new constructor allows you to pass in desired world width and height
- results from blobs no longer normalized but in desired world width and height range
- this version is not backwards compatible, and not likely to change how access is made to data


updates001j // 20090510: 
- improved and unified video textures handling
- fucked up on the code and broke presentime, id's, ...

updates001i // 20090501: 
- finished tracking code, all working great

updates001h // 20090405: 
updates001g // 20090400: 
- refined tracking, trackingsimple, calc code
- unified coords output
- get all values as float[12]

updates001f // 20090400: 
- main tracking code
updates001e // 20090400: 
- main trackedBlob class

updates001d // 20090216:
- new calc methods: new om: continuous diference
- Om's: STATIC_DIFFERENCE, CONTINUOUS_DIFFERENCE
- added videofade parameter
- each blob returns mass through getCentroidPixelcount
- more examples 

updates001c // 20090211: 
- support for non-square input video images (ie, 320x240 instead of 128x128)

updates001b // 20090210: 
- returns normalized values (centers and dims of blobs)
- returns normalized presence

updates001a // 20090210: 
- initial release. only calc method (no track,...)

