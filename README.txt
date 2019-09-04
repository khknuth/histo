
OPTBINS binning package v2.0
GNU General Public License Software Copyright: Kevin H. Knuth 2008

Developed by: Kevin H Knuth
Updated:  5 April 2008
Checked and Committed to GitHub: 4 Sept 2019

This program is free software; you can redistribute it and/or modify it 
under the terms of the GNU General Public License as published by the 
Free Software Foundation; either version 2 of the License, or any later 
version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along 
with this program; if not, write to the Free Software Foundation, Inc., 
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.


---------

The OPTBINS package consists of a library of Matlab routines that enable
users to determine optimal data-based histogram binning and representation.
Each Matlab m-file (command) has its own documentation that can be accessed by 
entering 'help command' on the command line, where command is the command 
of interest.  More information on the theory underlying the code can be found
in the reference below.



In the event that optBINS is used in published research, please cite the 
following paper
https://arxiv.org/abs/physics/0605197

This paper is currently in review, so please check with Knuth's CV online before referencing.

 

Other applicable references are...

The test for excessive rounding was first published in:
Knuth K.H., Castle J.P., Wheeler K.R. 2006. Identifying excessively rounded or truncated data. (Invited paper), Proceedings of the 17th meeting of The International Association for Statistical Computing—European Regional Section: Computational Statistics (COMPSTAT 2006), Rome, Italy, Aug 2006.

nsOPTBINS uses portions of code modified from C code copyrighted by Sivia and Skilling in 2006 through the GNU GPL.  If appropriate, the user should reference:
Sivia and Skilling, "Data Analysis: A Bayesian Tutorial", 2nd Ed., Oxford Univ. Press, 2006, pp. 188-189.



PACKAGE CONTENTS:

dispHIST	- displays a 1D histogram of a density model
dispMODEL	- displays a 1D density model
histMODEL	- develop a cell array model of a density model
histogram	- bins the data in multiple dimensions
isROUNDED	- determines whether the data are excessively rounded
moptBINS	- brute force algorithm to determine the number of bins in multiple dimensions
nsoptBINS	- nested sampling algorithm to determine the number of bins in multiple dimensions
optBINS		- brute force algorithm to determine the number of bins for one dimension


RECOMMENDED STARTER CODE:

% playing with a Gaussian density

data = randn(1,1000);
m = OPTBINS(data, 20)           % try OPTBINS
m = mOPTBINS(data, 20)          % try mOPTBINS
m = nsOPTBINS(data)             % try nsOPTBINS

h1 = dispHIST(data, m, 'errorbars');
h2 = dispHIST(data, m, 'thick');

m = nsOPTBINS(data,'mean')      % try nsOPTBINS

m = nsOPTBINS(data,'verbose')	% try nsOPTBINS

model = histMODEL(data,nsOPTBINS(data));
dispMODEL(model,'errorbars');



% playing with a 2D Gaussian density

data = randn(2,5000);
m = mOPTBINS(data, [20, 20])    % try mOPTBINS
m = nsOPTBINS(data)             % try nsOPTBINS

% Make a 2D bar graph
[counts binwidth centers] = histogram(data, m);
figure; bar3(counts,1,'c');




% test to see if data are excessively rounded or truncated

data = round(100*rand(1,10000))/100;	% generate rounded data
m = nsOPTBINS(data)




% playing with a Uniform density
% Only one bin is warranted

data = rand(1,1000);
m = OPTBINS(data, 20)


data = rand(2,1000);
m = nsOPTBINS(data)




