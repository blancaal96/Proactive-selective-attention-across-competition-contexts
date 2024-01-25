function [res_hb_val, res_hb_inv, res_lb_val, res_lb_inv, res_hb, res_lb, res_loc] = behavResults (Output, BlockType, Congruency)

   hb = 1;
   lb = 1;
   loc = 1;
   val = find (cell2mat(Congruency)==1);
   val_acc = Output(val);
   inv  = find (cell2mat(Congruency)==2);
   inv_acc = Output(inv);
    for a = 1: length(BlockType)
        if BlockType(a) == 1
            hb_acc(:,hb) = Output(:,a);
            hb_congruency(:,hb) = Congruency(:,a);
            hb = hb+1;
        elseif BlockType(a) == 2
            lb_acc(:,lb) = Output(:,a);
            lb_congruency(:,lb) = Congruency(:,a);
            lb = lb+1;
        else
            loc_acc(:,loc) = Output(:,a);
            loc = loc+1;
        end
    end
    hb_val = find (cell2mat(hb_congruency) == 1);
    hb_val_acc = hb_acc(hb_val);
    hb_inv  = find (cell2mat(hb_congruency) == 2);
    hb_inv_acc = hb_acc(hb_inv);
    
    lb_val = find (cell2mat(lb_congruency) == 1);
    lb_val_acc = lb_acc(lb_val);
    lb_inv  = find (cell2mat(lb_congruency) == 2);
    lb_inv_acc = lb_acc(lb_inv);
    
    if exist ('hb_acc', 'var')
        res_hb = mean(mean(hb_acc, 'omitnan'));
    end
    if exist ('lb_acc', 'var')
        res_lb = mean(mean(lb_acc, 'omitnan'));
    end
    if exist ('loc_acc', 'var')
        res_loc = mean(mean(loc_acc, 'omitnan'));
    end
    if exist ('hb_val_acc', 'var')
        res_hb_val = mean(mean(hb_val_acc, 'omitnan'));
    end
    if exist ('hb_inv_acc', 'var')
        res_hb_inv = mean(mean(hb_inv_acc, 'omitnan'));
    end
    if exist ('lb_val_acc', 'var')
        res_lb_val = mean(mean(lb_val_acc, 'omitnan'));
    end
    if exist ('lb_inv_acc', 'var')
        res_lb_inv = mean(mean(lb_inv_acc, 'omitnan'));
    end
    
end
            
        

   