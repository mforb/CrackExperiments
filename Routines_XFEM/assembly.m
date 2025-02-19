function sctrB = assembly(e,enrich_node,pos,cont,crack_node)

global node element orig_nn

sctr = element(e,:);
nn   = length(sctr);

if cont == 1
 for k = 1 : nn
    sctrBfem(2*k-1) = 2*sctr(k)-1 ;
    sctrBfem(2*k)   = 2*sctr(k)   ;
 end
else
   sctrBfem = [];
end

if ( any(enrich_node(sctr)) == 0 ) & isempty(intersect(crack_node,sctr)) % Non-enriched elements
    sctrB = sctrBfem ;
else
    tn = size(find(enrich_node(sctr) == 1),1);
    sn = size(find(enrich_node(sctr) == 2),1);
    ssn = size(find(enrich_node(sctr) == 3),1) ;
    sctrBxfem = zeros(1,2*(sn*1+tn*4+ssn*1));%TENR
    cnt = 0 ;
    for k = 1 : nn
        if ( enrich_node(sctr(k)) == 2) % split or crack_node
            cnt = cnt + 1 ;
            %if ismember(sctr(k),crack_node)
            %% find positiong in crack_node and add that to orig_nn
              %in = find(sctr(k),crack_node);
              %sctrBxfem(2*cnt - 1) = 2 *(orig_nn+in) - 1;
              %sctrBxfem(2*cnt    ) = 2 *(orig_nn+in)    ;
            %else
            sctrBxfem(2*cnt - 1) = 2 * pos(sctr(k)) - 1;
            sctrBxfem(2*cnt    ) = 2 * pos(sctr(k))    ;
            %end
        elseif( enrich_node(sctr(k)) == 3)  %split by material
            cnt = cnt + 1 ;
            sctrBxfem(2*cnt - 1) = 2 * pos(sctr(k)) - 1 ;
            sctrBxfem(2*cnt    ) = 2 * pos(sctr(k))     ;
        elseif ( enrich_node(sctr(k)) == 1) % tip
            cnt = cnt + 1 ;
            sctrBxfem(2*cnt - 1) = 2 * pos(sctr(k)) - 1;
            sctrBxfem(2*cnt    ) = 2 * pos(sctr(k))    ;

            cnt = cnt + 1 ;
            sctrBxfem(2*cnt - 1) = 2 * (pos(sctr(k))+1) - 1;
            sctrBxfem(2*cnt    ) = 2 * (pos(sctr(k))+1)    ;

            cnt = cnt + 1 ;
            sctrBxfem(2*cnt - 1) = 2 * (pos(sctr(k))+2) - 1;
            sctrBxfem(2*cnt    ) = 2 * (pos(sctr(k))+2)    ;

            cnt = cnt + 1 ;
            sctrBxfem(2*cnt - 1) = 2 * (pos(sctr(k))+3) - 1;
            sctrBxfem(2*cnt    ) = 2 * (pos(sctr(k))+3)    ;
        end
    end
    sctrB = [ sctrBfem sctrBxfem ];
end
