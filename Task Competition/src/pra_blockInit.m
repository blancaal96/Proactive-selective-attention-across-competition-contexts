%% INITIALIZATION OF THE CUES IN THAT PRACTICE BLOCK
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez y Chema G. Pe�alver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

%% 1. BLOCK INITIALIZATION: CUE SELECTION
% -------------------------------------------------------------------------
% According to the type of block, one pair of cues or others will be used

    FaceCue = PRACT.BlockCuesFace{block};
    NameCue = PRACT.BlockCuesName{block};
    BlockCueFace = CUE.Texture{FaceCue};
    BlockCueName = CUE.Texture{NameCue};

