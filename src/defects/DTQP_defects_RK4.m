%--------------------------------------------------------------------------
% DTQP_defects_RK4.m
% Create matrices for the fourth-order Runge-Kutta method
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: Daniel R. Herber (danielrherber), University of 
% Illinois at Urbana-Champaign
% Project link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
function [Aeq,beq] = DTQP_defects_RK4(A,B,G,d,p,opts)

    % extract some of the variables in p
    nt = p.nt; nu = p.nu; ns = p.ns; np = p.np;
    nd = p.nd; h = p.h; nx = p.nx; tm = p.tm;

    % matrix form of I in the formulas
    K = kron(eye(ns),ones(nt-1,1));

    %------------------------------------------------------------------
    % calculate matrices
    %------------------------------------------------------------------
    % find time dependent matrices
    At = DTQP_tmultiprod(A,p);
    Bt = DTQP_tmultiprod(B,p);
    Gt = DTQP_tmultiprod(G,p);
    dt = DTQP_tmultiprod(d,p);

    % find matrix values for  time grid midpoints
    Am = DTQP_tmultiprod(A,p,tm);
    Bm = DTQP_tmultiprod(B,p,tm);
    Gm = DTQP_tmultiprod(G,p,tm);
    dm = DTQP_tmultiprod(d,p,tm);

    % calculate matrix products
    A0 = At(1:nt-1,:,:);
    A1 = At(2:nt,:,:);
    AmAm = multiprod(Am,Am,[2 3],[2 3]); % 1
    AmAmA0 = multiprod(AmAm,A0,[2 3],[2 3]); % 2
    A1AmAm = multiprod(A1,AmAm,[2 3],[2 3]); % 3
    AmA0 = multiprod(Am,A0,[2 3],[2 3]); % 4
    A1Am = multiprod(A1,Am,[2 3],[2 3]); % 5
    A1AmAmA0 = multiprod(A1Am,AmA0,[2 3],[2 3]); % 6

    if nu ~= 0
        B0 = Bt(1:nt-1,:,:);
        AmB0 = multiprod(Am,B0,[2 3],[2 3]); % 7
        AmBm = multiprod(Am,Bm,[2 3],[2 3]); % 8
        A1Bm = multiprod(A1,Bm,[2 3],[2 3]); % 9
        AmAmB0 = multiprod(AmAm,B0,[2 3],[2 3]); % 10
        A1AmBm = multiprod(A1Am,Bm,[2 3],[2 3]); % 11
        A1AmAmB0 = multiprod(A1,AmAmB0,[2 3],[2 3]); % 12
    end

    if np ~= 0
        G0 = Gt(1:nt-1,:,:);
        AmG0 = multiprod(Am,G0,[2 3],[2 3]); % 13
        AmGm = multiprod(Am,Gm,[2 3],[2 3]); % 14
        A1Gm = multiprod(A1,Gm,[2 3],[2 3]); % 15
        AmAmG0 = multiprod(AmAm,G0,[2 3],[2 3]); % 16
        A1AmGm = multiprod(A1Am,Gm,[2 3],[2 3]); % 17
        A1AmAmG0 = multiprod(A1,AmAmG0,[2 3],[2 3]); % 18
    end

    if nd ~= 0
        d0 = dt(1:nt-1,:,:);
        Amd0 = multiprod(Am,d0,[2 3],[2 3]); % 19
        Amdm = multiprod(Am,dm,[2 3],[2 3]); % 20
        A1dm = multiprod(A1,dm,[2 3],[2 3]); % 21
        AmAmd0 = multiprod(AmAm,d0,[2 3],[2 3]); % 22
        A1Amdm = multiprod(A1Am,dm,[2 3],[2 3]); % 23
        A1AmAmd0 = multiprod(A1,AmAmd0,[2 3],[2 3]); % 24
    end
    %------------------------------------------------------------------

    % initialize sequences 
    If = []; Jf = []; Vf = [];

    % defect constraint of row continuous constraints
    for i = 1:ns
        % current defect constraint row indices
        DefectIndices = (i-1)*(nt-1)+1:i*(nt-1);

        %------------------------------------------------------------------
        % controls
        %------------------------------------------------------------------
        if nu ~= 0
            I = repmat(DefectIndices,1,nu); % current defect constraint row indices
            J = 1:nu*nt; % current optimization variable column indices
            J(nt:nt:nu*nt) = []; % remove endpoints
            % T = 1:nu*nt; T(nt:nt:nu*nt) = [];
            T = J; % time indexing vector
            H = repmat(h,nu,1); % vector of time steps

            % extract matrices
            Bv = reshape(Bt(:,i,:),[],1);
            Bmv = reshape(Bm(:,i,:),[],1);
            AmB0v = reshape(AmB0(:,i,:),[],1);
            AmBmv = reshape(AmBm(:,i,:),[],1);
            A1Bmv = reshape(A1Bm(:,i,:),[],1);
            AmAmB0v = reshape(AmAmB0(:,i,:),[],1);
            A1AmBmv = reshape(A1AmBm(:,i,:),[],1);
            A1AmAmB0v = reshape(A1AmAmB0(:,i,:),[],1);

            % theta values           
            V3 = -H.*( Bmv/3 + Bv(T)/6 + H.*AmB0v/6 + H.*AmBmv/12 + ...
                H.*A1Bmv/12 + H.^2.*AmAmB0v/12 + H.^2.*A1AmBmv/24 + ...
                H.^3.*A1AmAmB0v/24 ); % theta 3
            V4 = -H.*( Bmv/3 + Bv(T+1)/6 + H.*AmBmv/12 + H.*A1Bmv/12 + ...
                H.^2.*A1AmBmv/24 ); % theta 4

            % combine with
            Is = [I,I];
            Js = [J,J+1];
            Vs = [V3;V4];

            % remove zeros
            ZeroIndex = (Vs==0);
            Is(ZeroIndex) = []; Js(ZeroIndex) = []; Vs(ZeroIndex) = [];

            % combine with 
            If = [If,Is]; Jf = [Jf,Js]; Vf = [Vf;Vs];

        end
        %------------------------------------------------------------------

        %------------------------------------------------------------------
        % states
        %------------------------------------------------------------------
        % if ns ~= 0 % always is at least one state
            I = repmat(DefectIndices,1,ns); % current defect constraint row indices
            J = nu*nt+1:(nu+ns)*nt; % current optimization variable column indices
            J(nt:nt:end) = []; % remove endpoints
            % T = 1:ns*nt; T(nt:nt:ns*nt) = [];
            T = J - nt*nu; % time indexing vector (faster than line above)
            H = repmat(h,ns,1); % vector of time steps

            % extract matrices
            Av = reshape(At(:,i,:),[],1);
            Amv = reshape(Am(:,i,:),[],1);
            AmAmv = reshape(AmAm(:,i,:),[],1);
            AmAmA0v = reshape(AmAmA0(:,i,:),[],1);
            A1AmAmv = reshape(A1AmAm(:,i,:),[],1);
            AmA0v = reshape(AmA0(:,i,:),[],1);
            A1Amv = reshape(A1Am(:,i,:),[],1);
            A1AmAmA0v = reshape(A1AmAmA0(:,i,:),[],1);

            % theta values
            V1 = -K(:,i) - H.*( Amv*2/3 + Av(T+1)/6 + Av(T)/6 + ...
                H.*AmAmv/6 + H.*A1Amv/6 + H.*AmA0v/6 + H.^2.*A1AmAmv/12 + ...
                H.^2.*AmAmA0v/12 + H.^3.*A1AmAmA0v/24 ); % theta 1
            V2 = K(:,i); % theta 2

            % combine
            Is = [I,I];
            Js = [J,J+1];
            Vs = [V1;V2];

            % remove zeros
            ZeroIndex = (Vs==0);
            Is(ZeroIndex) = []; Js(ZeroIndex) = []; Vs(ZeroIndex) = [];

            % combine 
            If = [If,Is]; Jf = [Jf,Js]; Vf = [Vf;Vs];
        % end
        %------------------------------------------------------------------

        %------------------------------------------------------------------
        % parameters
        %------------------------------------------------------------------
        if np ~= 0
            I = repmat(DefectIndices,1,np); % current defect constraint row indices
            J = kron(nt*(nu+ns)+(1:np), ones(1,nt-1)); % current optimization variable column indices
            T = 1:np*nt; T(nt:nt:np*nt) = []; % time indexing vector
            H = repmat(h,np,1); % vector of time steps

            % extract matrices
            Gv = reshape(Gt(:,i,:),[],1);
            Gmv = reshape(Gm(:,i,:),[],1);
            AmG0v = reshape(AmG0(:,i,:),[],1);
            AmGmv = reshape(AmGm(:,i,:),[],1);
            A1Gmv = reshape(A1Gm(:,i,:),[],1);
            AmAmG0v = reshape(AmAmG0(:,i,:),[],1);
            A1AmGmv = reshape(A1AmGm(:,i,:),[],1);
            A1AmAmG0v = reshape(A1AmAmG0(:,i,:),[],1);

            % theta values
            V51 = -H.*( Gmv/3 + Gv(T)/6 + H.*AmG0v/6 + H.*AmGmv/12 + ...
                H.*A1Gmv/12 + H.^2.*AmAmG0v/12 + H.^2.*A1AmGmv/24 + ...
                H.^3.*A1AmAmG0v/24 );
            V52 = -H.*( Gmv/3 + Gv(T+1)/6 + H.*AmGmv/12 + H.*A1Gmv/12 + ...
                H.^2.*A1AmGmv/24 );
            V = V51 + V52; % theta 5

            % remove zeros
            ZeroIndex = (V==0);
            I(ZeroIndex) = []; J(ZeroIndex) = []; V(ZeroIndex) = [];

            % combine
            If = [If,I]; Jf = [Jf,J]; Vf = [Vf;V];
        end
        %------------------------------------------------------------------
    end

	% output sparse matrix   
    Aeq = sparse(If,Jf,Vf,ns*(nt-1),nx);

    %------------------------------------------------------------------
	% disturbance
    %------------------------------------------------------------------
    if nd ~= 0
        % initialize sequences 
        Ifb = []; Vfb = [];

        for i = 1:ns % defect constraint of row continuous constraints
            I = (i-1)*(nt-1)+1:i*(nt-1); % row (continuous)
            T = 1:nt-1; % time indexing vector
            H = h; % vector of time steps

            % extract matrices
            dv = reshape(dt(:,i,:),[],1);
            dmv = reshape(dm(:,i,:),[],1);
            Amd0v = reshape(Amd0(:,i,:),[],1);
            Amdmv = reshape(Amdm(:,i,:),[],1);
            A1dmv = reshape(A1dm(:,i,:),[],1);
            AmAmd0v = reshape(AmAmd0(:,i,:),[],1);
            A1Amdmv = reshape(A1Amdm(:,i,:),[],1);
            A1AmAmd0v = reshape(A1AmAmd0(:,i,:),[],1);

            % nu values
            Vnu1 = H.*( dmv/3 + dv(T)/6 + H.*Amd0v/6 + H.*Amdmv/12 + ...
                H.*A1dmv/12 + H.^2.*AmAmd0v/12 + H.^2.*A1Amdmv/24 + ...
                H.^3.*A1AmAmd0v/24 );
            Vnu2 = H.*( dmv/3 + dv(T+1)/6 + H.*Amdmv/12 + H.*A1dmv/12 + ...
                H.^2.*A1Amdmv/24 );
            V = Vnu1 + Vnu2; % theta 5

            % remove zeros
            ZeroIndex = (V==0);
            I(ZeroIndex) = []; V(ZeroIndex) = [];

            % combine with 
            Ifb = [Ifb,I]; Vfb = [Vfb;V];

        end

        beq = sparse(Ifb,1,Vfb,ns*(nt-1),1);   
    else
        % output sparse matrix
        beq = sparse([],[],[],ns*(nt-1),1);
    end
    %------------------------------------------------------------------
end