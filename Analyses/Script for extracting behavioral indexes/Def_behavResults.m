% Script to generate averages per condition. As arguments you always put
% results from both ACC and RT, but only calculates one of the two,
% depending on the flag that is written at the end. 
function [res_hi_val_face, res_hi_inv_face, res_hi_val_name, res_hi_inv_name, res_lo_val_face, res_lo_inv_face, res_lo_val_name, res_lo_inv_name, res_hi_val,...
         res_hi_inv, res_lo_val, res_lo_inv, res_hi, res_lo, res_loc, res_val, res_inv, res_face, res_name,...
         res_hi_face, res_hi_name, res_lo_face, res_lo_name, res_val_face, res_val_name, res_inv_face, res_inv_name, res_Output, Fnumber] = Def_behavResults (Output, Output_RT, BlockType, Validity, Stim, Flag)

   hi = 1;
   lo = 1;
   loc = 1;

   for i = 1: size (Validity, 1)
       for j = 1: size (Validity, 2)
           if isempty(Validity{i,j})
               Validity2{i,j} = nan;
           else
                Validity2{i,j}= Validity{i,j};
           end
       end
   end
   Validity = Validity2;
   if size(Validity,2) ==71
       for i = 1:size(Validity, 1)
        Validity{i,72} = nan ;
        end
   end
   if strcmp (Flag, 'RT')
       for i = 1:size (Output,1)
           for j  = 1:size (Output,2)
               if Output(i,j) == 0
                       Output_RT (i,j)= NaN;%For Rt analysis we get rid of trials with acc= 0
               end
           end
       end
       Output = Output_RT;
   end
   mean_rt = mean(mean(Output_RT, 'omitnan'),'omitnan'); %The mean we use to detect outliers
   Output2 = reshape (Output_RT, [1728, 1]);
   sd = std(Output2,'omitnan');

   upper = mean_rt + (sd*2);
   lower = mean_rt - (sd*2);
   Outliers = Output_RT <upper & Output_RT >lower;%Filtering the data without outliers 0 is an outlier
   if strcmp (Flag, 'RT')
    Output = Output.*Outliers;

   end


val = cell2mat(Validity) ==1;
inv = cell2mat(Validity) ==2;

name = cell2mat (Stim) ==2;
face = cell2mat(Stim) ==1;



       val2 = [];
       inv2 = [];
       face2 = [];
       name2 = [];
       for i = 1: size (Stim, 1)
           for j = 1: size (Stim,2)
               if val(i,j)==0
                   val2(i,j) = nan;
               else
                   val2(i,j) = 1;
               end
               if inv(i,j)==0
                   inv2(i,j) = nan;
               else
                   inv2(i,j)  = 1;
               end
               if face(i,j)==0
                   face2(i,j) = nan;
               else
                   face2(i,j)  = 1;
               end
               if name(i,j)==0
                   name2(i,j) = nan;
               else
                   name2(i,j)  = 1;
               end
           end
       end
       val = val2;
       inv = inv2;
       face = face2;
       name = name2;

   val_acc = Output.*val;

   inv_acc = Output.*inv;

   face_acc = Output.*face;

   name_acc = Output.*name;



if strcmp (Flag, 'RT')
     for i = 1:size (Output,1)
          for j  = 1:size (Output,2)
              %Inclusión de más variables
              if isnan(face_acc(i,j)) || isnan(val_acc(i,j))
                  val_face_acc(i,j) = face_acc(i,j)*val_acc(i,j);
              else
                  val_face_acc(i,j) = face_acc(i,j);
              end
              if isnan(face_acc(i,j)) || isnan(inv_acc(i,j));
                  inv_face_acc(i,j) = face_acc(i,j)*inv_acc(i,j);
              else
                  inv_face_acc(i,j) = face_acc(i,j);
              end
              if isnan(name_acc(i,j)) || isnan(val_acc(i,j));
                  val_name_acc(i,j) = name_acc(i,j)*val_acc(i,j);
              else
                  val_name_acc(i,j) = name_acc(i,j);
              end
              if isnan(name_acc(i,j)) || isnan(inv_acc(i,j));
                  inv_name_acc(i,j) = name_acc(i,j)*inv_acc(i,j);
              else
                  inv_name_acc(i,j) = name_acc(i,j);
              end
          end
      end


 else

   val_face_acc = face_acc.*val_acc;
   val_name_acc = name_acc.*val_acc;
   inv_face_acc = face_acc.*inv_acc;
   inv_name_acc = name_acc.*inv_acc;


end
  %Classifying per block (high, low competition)

    for a = 1: length(BlockType)
        if BlockType(a) == 1
            hi_acc(:,hi) = Output(:,a);



            val_hi_acc(:,hi) = val_acc(:,a);

            hi_face_acc(:,hi) = face_acc(:,a);
            hi_name_acc(:,hi) = name_acc(:,a);

            inv_hi_acc(:,hi) = inv_acc(:,a);


            face_val_hi_acc(:,hi) = val_face_acc(:,a);
            face_inv_hi_acc(:,hi) = inv_face_acc(:,a);
            name_val_hi_acc(:,hi) = val_name_acc(:,a);
            name_inv_hi_acc(:,hi) = inv_name_acc(:,a);
            hi = hi+1;
        elseif BlockType(a) == 2
            lo_acc(:,lo) = Output(:,a);
            val_lo_acc(:,lo) = val_acc(:,a);
            inv_lo_acc(:,lo) = inv_acc(:,a);

            lo_val_acc =  val_lo_acc(:,lo);
            lo_inv_acc = inv_lo_acc(:,lo);

            lo_face_acc(:,lo) = face_acc(:,a);
            lo_name_acc(:,lo) = name_acc(:,a);


            face_lo_acc(:,lo) = face_acc(:,a);
            name_lo_acc(:,lo) = name_acc(:,a);
            face_val_lo_acc(:,lo) = val_face_acc(:,a);
            face_inv_lo_acc(:,lo) = inv_face_acc(:,a);
            name_val_lo_acc(:,lo) = val_name_acc(:,a);
            name_inv_lo_acc(:,lo) = inv_name_acc(:,a);
            lo = lo+1;


        else
            loc_acc(:,loc) = Output(:,a);
            loc = loc+1;
        end
    end







    if exist ('hi_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %Here we transform outliers value that have a value of 0 to NaN values
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                 hi_acc = Output3;
                end
            end
        Output5 = mean(hi_acc, 'omitnan');
        res_hi = mean(Output5, 'omitnan');
    end


    if exist ('lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                lo_acc = Output3;
                end
             end
        Output5 = mean(lo_acc, 'omitnan');
        res_lo = mean(Output5, 'omitnan');
    end


    if exist ('loc_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = loc_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                loc_acc = Output3;
                end
             end
        Output5 = mean(loc_acc, 'omitnan');
        res_loc = mean(Output5, 'omitnan');
    end





    if exist ('val_hi_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = val_hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                val_hi_acc = Output3;
                end
             end
        Output5 = mean(val_hi_acc, 'omitnan');
        res_hi_val = mean(Output5, 'omitnan');
    end

    if exist ('inv_hi_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = inv_hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                inv_hi_acc = Output3;
                end
             end
        Output5 = mean(inv_hi_acc, 'omitnan');
        res_hi_inv = mean(Output5, 'omitnan');
    end

    if exist ('val_lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = val_lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                val_lo_acc = Output3;
                end
             end
        Output5 = mean(val_lo_acc, 'omitnan');
        res_lo_val = mean(Output5, 'omitnan');
    end

    if exist ('inv_lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = inv_lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                inv_lo_acc = Output3;
                end
             end
        Output5 = mean(inv_lo_acc, 'omitnan');
        res_lo_inv = mean(Output5, 'omitnan');
    end

    if exist ('face_val_hi_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = face_val_hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                face_val_hi_acc = Output3;
                end
             end
        Output5 = mean(face_val_hi_acc, 'omitnan');
        res_hi_val_face = mean(Output5, 'omitnan');
    end

    if exist ('face_inv_hi_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = face_inv_hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                face_inv_hi_acc = Output3;
                end
             end
        Output5 = mean(face_inv_hi_acc, 'omitnan');
        res_hi_inv_face = mean(Output5, 'omitnan');
    end

    if exist ('name_val_hi_acc', 'var')
             if strcmp (Flag, 'RT')
                Output3 = name_val_hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                name_val_hi_acc = Output3;
                end
             end
        Output5 = mean(name_val_hi_acc, 'omitnan');
        res_hi_val_name = mean(Output5, 'omitnan');
    end

    if exist ('name_inv_hi_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = name_inv_hi_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                name_inv_hi_acc = Output3;
                end
             end
        Output5 = mean(name_inv_hi_acc, 'omitnan');
        res_hi_inv_name = mean(Output5, 'omitnan');
    end

    if exist ('face_val_lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = face_val_lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                face_val_lo_acc = Output3;
                end
             end
        Output5 = mean(face_val_lo_acc, 'omitnan');
        res_lo_val_face = mean(Output5, 'omitnan');
    end

    if exist ('face_inv_lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = face_inv_lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                face_inv_lo_acc = Output3;
                end
             end
        Output5 = mean(face_inv_lo_acc, 'omitnan');
        res_lo_inv_face = mean(Output5, 'omitnan');
    end

    if exist ('name_val_lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = name_val_lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                name_val_lo_acc = Output3;
                end
             end
        Output5 = mean(name_val_lo_acc, 'omitnan');
        res_lo_val_name = mean(Output5, 'omitnan');
    end

    if exist ('name_inv_lo_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = name_inv_lo_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                name_inv_lo_acc = Output3;
                end
             end
        Output5 = mean(name_inv_lo_acc, 'omitnan');
        res_lo_inv_name = mean(Output5, 'omitnan');
    end

    if exist ('val_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = val_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                val_acc = Output3;
                end
             end

        res_val = mean(mean(val_acc, 'omitnan'), 'omitnan');
    end

    if exist ('inv_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = inv_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                inv_acc = Output3;
                end
             end

        res_inv = mean(mean(inv_acc, 'omitnan'), 'omitnan');
    end

    if exist ('face_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = face_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                face_acc = Output3;
                end
             end

        res_face = mean(mean(face_acc, 'omitnan'), 'omitnan');
    end

    if exist ('name_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = name_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                name_acc = Output3;
                end
             end

        res_name = mean(mean(name_acc, 'omitnan'), 'omitnan');
    end

    if exist ('Output', 'var')
           if strcmp (Flag, 'RT')
                number = 0;

                mean_rt = mean(mean(Output, 'omitnan'),'omitnan');
                Output2 = reshape (Output, [1728, 1]);
                sd = std(Output2,'omitnan');
                upper = mean_rt + (sd*2);
                lower = mean_rt - (sd*2);
                Outliers = Output <upper & Output >lower;
                Output = Output.*Outliers;
                for i = 1:size (Output,1)
                     for j  = 1:size (Output,2)
                        if Output(i,j) == 0
                                Output (i,j)= nan;
                                number = number+1;
                        end
                     end
                Fnumber = number; %Number of outliers

                end
           end

        res_Output = mean(mean(Output, 'omitnan'), 'omitnan');
    end

    %For interactions 2 x 2
    if exist ('hi_face_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = hi_face_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2)
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                hi_face_acc = Output3;
                end
             end

        res_hi_face = mean(mean(hi_face_acc, 'omitnan'), 'omitnan');
    end

    if exist ('hi_name_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = hi_name_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                hi_name_acc = Output3;
                end
             end

        res_hi_name = mean(mean(hi_name_acc, 'omitnan'), 'omitnan');
    end

    if exist ('lo_face_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = lo_face_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                lo_face_acc = Output3;
                end
             end

        res_lo_face = mean(mean(lo_face_acc, 'omitnan'), 'omitnan');
    end

    if exist ('lo_name_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = lo_name_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                lo_name_acc = Output3;
                end
             end

        res_lo_name = mean(mean(lo_name_acc, 'omitnan'), 'omitnan');
    end

    if exist ('val_face_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = val_face_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2) %
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                val_face_acc = Output3;
                end
             end

        res_val_face = mean(mean(val_face_acc, 'omitnan'), 'omitnan');
    end

    if exist ('val_name_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = val_name_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2)
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                val_name_acc = Output3;
                end
             end

        res_val_name = mean(mean(val_name_acc, 'omitnan'), 'omitnan');
    end

    if exist ('inv_face_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = inv_face_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2)
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                inv_face_acc = Output3;
                end
             end

        res_inv_face = mean(mean(inv_face_acc, 'omitnan'), 'omitnan');
    end

    if exist ('inv_name_acc', 'var')
            if strcmp (Flag, 'RT')
                Output3 = inv_name_acc;

                for i = 1:size (Output3,1)
                     for j  = 1:size (Output3,2)
                        if Output3(i,j) == 0
                                Output3 (i,j)= nan;
                        end
                     end
                inv_name_acc = Output3;
                end
             end

        res_inv_name = mean(mean(inv_name_acc, 'omitnan'), 'omitnan');
    end


end
