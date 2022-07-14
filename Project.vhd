--				TAREQ SHANNAK 1181404
-- 				      	PROJECT 
-------------------------------------------------- 
--------------BASIC GATES WITH DELAY--------------
--------------------------------------------------

----------------------AND2----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AND2 IS
	PORT(A,B: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END AND2;

ARCHITECTURE structural OF AND2 IS
BEGIN
	F <= A AND B AFTER 8 NS;
END;
----------------------AND3----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AND3 IS
	PORT(A,B,C: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END AND3;

ARCHITECTURE structural OF AND3 IS
BEGIN
	F <= A AND B AND C AFTER 8 NS;
END;
----------------------AND4----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AND4 IS
	PORT(A,B,C,D: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END AND4;

ARCHITECTURE structural OF AND4 IS
BEGIN
	F <= A AND B AND C AND D AFTER 8 NS;
END;
----------------------AND5----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AND5 IS
	PORT(A,B,C,D,E: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END AND5;

ARCHITECTURE structural OF AND5 IS
BEGIN
	F <= A AND B AND C AND D AND E AFTER 8 NS;
END;
----------------------OR2----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY OR2 IS
	PORT(A,B: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END OR2;

ARCHITECTURE structural OF OR2 IS
BEGIN
	F <= A OR B AFTER 8 NS;
END;
----------------------OR3----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY OR3 IS
	PORT(A,B,C: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END OR3;

ARCHITECTURE structural OF OR3 IS
BEGIN
	F <= A OR B OR C AFTER 8 NS;
END; 
----------------------OR4----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY OR4 IS
	PORT(A,B,C,D: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END OR4;

ARCHITECTURE structural OF OR4 IS
BEGIN
	F <= A OR B OR C OR D AFTER 8 NS;
END;
----------------------OR5----------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY OR5 IS
	PORT(A,B,C,D,E: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END OR5;

ARCHITECTURE structural OF OR5 IS
BEGIN
	F <= A OR B OR C OR D OR E AFTER 8 NS;
END;
---------------------XOR2---------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY XOR2 IS
	PORT(A,B: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END XOR2;

ARCHITECTURE structural OF XOR2 IS
BEGIN
	F <= A XOR B AFTER 12 NS;
END; 										 
---------------------NAND2--------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY NAND2 IS
	PORT(A,B: IN STD_LOGIC:='0';
	F: OUT STD_LOGIC:='0');
END NAND2;

ARCHITECTURE structural OF NAND2 IS
BEGIN
	F <= A NAND B AFTER 6 NS;
END;

--------------------------------------------------
----------------One Bit Full Adder----------------
-------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FA IS
	PORT(A,B,Carryin: IN STD_LOGIC:='0';
	Sum,Carryout: OUT STD_LOGIC:='0');
END FA;

ARCHITECTURE structural OF FA IS	  
SIGNAL T,R,E,Q,S,H,K: STD_LOGIC := '0';
BEGIN  
	-- Full Adder Using NAND gates (Faster)
	G1: ENTITY WORK.NAND2(structural) PORT MAP(A,B,T);
	G2: ENTITY WORK.NAND2(structural) PORT MAP(T,A,R);
	G3: ENTITY WORK.NAND2(structural) PORT MAP(T,B,E);
	G4: ENTITY WORK.NAND2(structural) PORT MAP(R,E,Q);
	G5: ENTITY WORK.NAND2(structural) PORT MAP(Q,Carryin,S);  
	G6: ENTITY WORK.NAND2(structural) PORT MAP(S,T,Carryout);
	G7: ENTITY WORK.NAND2(structural) PORT MAP(S,Carryin,H);
	G8: ENTITY WORK.NAND2(structural) PORT MAP(S,Q,K);
	G9: ENTITY WORK.NAND2(structural) PORT MAP(H,K,Sum);  		
		-- Another way to implement Full Adder (Slower)
		--G1: ENTITY WORK.XOR2(structural) PORT MAP(A,B,X);	
		--G2: ENTITY WORK.XOR2(structural) PORT MAP(X,Carryin,Sum);
		--G3: ENTITY WORK.AND2(structural) PORT MAP(X,Carryin,Y);
		--G4: ENTITY WORK.AND2(structural) PORT MAP(A,B,Z);
		--G5: ENTITY WORK.OR2(structural) PORT MAP(Y,Z,Carryout);
END;

--------------------------------------------------
------------Carry Lookahead Generator-------------
-------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY carryGenerator IS
	PORT(P,G: IN STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	Carryin: IN STD_LOGIC:='0';				  
	Carryout: OUT STD_LOGIC_VECTOR(4 DOWNTO 0):="00000");
END carryGenerator;

ARCHITECTURE carryLookahead OF carryGenerator IS 
SIGNAL C,GC: STD_LOGIC_VECTOR(4 DOWNTO 0):="00000";
SIGNAL PG: STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
SIGNAL PPG: STD_LOGIC_VECTOR(3 DOWNTO 1):="000";
SIGNAL PPPG: STD_LOGIC_VECTOR(3 DOWNTO 2):="00";
SIGNAL PPPPG: STD_LOGIC:='0';
BEGIN	 
	GC <= G(3 DOWNTO 0)&C(0);
	C(0) <= Carryin;
	Carryout <= C; 	
																	
	gen1: FOR i IN 0 TO 3 GENERATE
	BEGIN
		G: ENTITY WORK.AND2(structural) PORT MAP(P(i),GC(i),PG(i));
	END GENERATE;
	
	gen2: FOR i IN 1 TO 3 GENERATE
	BEGIN
		G: ENTITY WORK.AND3(structural) PORT MAP(P(i),P(i-1),GC(i-1),PPG(i));
	END GENERATE;
	
	gen3: FOR i IN 2 TO 3 GENERATE
	BEGIN
		G: ENTITY WORK.AND4(structural) PORT MAP(P(i),P(i-1),P(i-2),GC(i-2),PPPG(i));
	END GENERATE;
	
	A1: ENTITY WORK.OR2(structural) PORT MAP(G(0), PG(0), C(1));
	A2: ENTITY WORK.OR3(structural) PORT MAP(GC(2), PG(1), PPG(1), C(2));					 		
	A3: ENTITY WORK.OR4(structural) PORT MAP(GC(3), PG(2), PPG(2), PPPG(2), C(3));	 													 		
	A4: ENTITY WORK.AND5(structural) PORT MAP(P(3), P(2), P(1), P(0), GC(0), PPPPG);
	A44: ENTITY WORK.OR5(structural) PORT MAP(GC(4), PG(3), PPG(3), PPPG(3), PPPPG, C(4));										
END;
--------------------------------------------------
---------------Four Bit Full Adder----------------
-------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FA4 IS
	PORT(A,B: IN STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	Carryin: IN STD_LOGIC:='0';
	Sum: OUT STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	Carryout: OUT STD_LOGIC:='0');
END FA4;

------------------------------------------------
--------------- 4 Bit Ripple FA ----------------
ARCHITECTURE ripple OF FA4 IS 
SIGNAL C: STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN	
	C(0) <= Carryin;
	Carryout <= C(4);
	gen1: FOR i IN 0 TO 3 GENERATE
	BEGIN
		G: ENTITY WORK.FA(structural) PORT MAP(A(i),B(i),C(i),Sum(i),C(i+1));
	END GENERATE;								  
END;
 
------------------------------------------------
------- 4 Bit Adder With Carry Lookahead -------
ARCHITECTURE lookahead OF FA4 IS 
SIGNAL C: STD_LOGIC_VECTOR(4 DOWNTO 0):="00000";
SIGNAL P,G: STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
BEGIN	
	C(0) <= Carryin;
	Carryout <= C(4);	
	GG: ENTITY WORK.carryGenerator(carryLookahead) PORT MAP(P,G,Carryin,C);
	gen1: FOR i IN 0 TO 3 GENERATE	 
		BEGIN 
			G1: ENTITY WORK.XOR2(structural) PORT MAP(A(i),B(i),P(i));
			G2: ENTITY WORK.AND2(structural) PORT MAP(A(i),B(i),G(i));
			G3: ENTITY WORK.XOR2(structural) PORT MAP(P(i),C(i),Sum(i));
		END GENERATE;						
END; 
--------------------------------------------------
--------------------BCD Adder---------------------
-------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BCD IS
	PORT(A,B: IN STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	Carryin: IN STD_LOGIC:='0';
	Sum: OUT STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	Carryout: OUT STD_LOGIC:='0');
END BCD;

------------------------------------------------
-------------- Ripple BCD Adder ----------------
ARCHITECTURE ripple OF BCD IS 
SIGNAL AA,BB: STD_LOGIC_VECTOR(3 DOWNTO 0):= "0000";
SIGNAL X,Y,Z,R: STD_LOGIC:='0';
BEGIN													 
	BB(1) <= BB(2);
	Carryout <= BB(2);
	G1: ENTITY WORK.FA4(ripple) PORT MAP(A,B,Carryin,AA,X);	
	G2: ENTITY WORK.AND2(structural) PORT MAP(AA(3),AA(2),Y);	
	G3: ENTITY WORK.AND2(structural) PORT MAP(AA(3),AA(1),Z);	
	G4: ENTITY WORK.OR3(structural) PORT MAP(X,Y,Z,BB(2));		   
	G5: ENTITY WORK.FA4(ripple) PORT MAP(AA,BB,'0',SUM,R);	
END;
 
------------------------------------------------
-------- BCD Adder With Carry Lookahead --------
ARCHITECTURE lookahead OF BCD IS 
SIGNAL AA,BB: STD_LOGIC_VECTOR(3 DOWNTO 0):= "0000";
SIGNAL X,Y,Z,R: STD_LOGIC:='0';
BEGIN													 
	BB(1) <= BB(2);
	Carryout <= BB(2);
	G1: ENTITY WORK.FA4(lookahead) PORT MAP(A,B,Carryin,AA,X);	
	G2: ENTITY WORK.AND2(structural) PORT MAP(AA(3),AA(2),Y);	
	G3: ENTITY WORK.AND2(structural) PORT MAP(AA(3),AA(1),Z);	
	G4: ENTITY WORK.OR3(structural) PORT MAP(X,Y,Z,BB(2));		   
	G5: ENTITY WORK.FA4(lookahead) PORT MAP(AA,BB,'0',SUM,R);	
END;

--------------------------------------------------
--------------------- System ---------------------
--------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY System IS
	PORT(A,B: IN STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";	 
	Sum: OUT STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";
	Carryout: OUT STD_LOGIC:='0');
END System;

------------------------------------------------
---------- System With Ripple Adder ------------
ARCHITECTURE ripple OF System IS 
SIGNAL X: STD_LOGIC;
BEGIN													 
	G1: ENTITY WORK.BCD(ripple) PORT MAP(A(3 DOWNTO 0),B(3 DOWNTO 0),'0',Sum(3 DOWNTO 0),X);	
	G2: ENTITY WORK.BCD(ripple) PORT MAP(A(7 DOWNTO 4),B(7 DOWNTO 4),X,Sum(7 DOWNTO 4),Carryout);	
END;   
  
------------------------------------------------
------ System With Carry Lookahead Adder -------
ARCHITECTURE lookahead OF System IS 
SIGNAL X: STD_LOGIC;
BEGIN													 
	G1: ENTITY WORK.BCD(lookahead) PORT MAP(A(3 DOWNTO 0),B(3 DOWNTO 0),'0',Sum(3 DOWNTO 0),X);	
	G2: ENTITY WORK.BCD(lookahead) PORT MAP(A(7 DOWNTO 4),B(7 DOWNTO 4),X,Sum(7 DOWNTO 4),Carryout);	
END;
  
--------------------------------------------------
----------------- Test Generator -----------------
--------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_ARITH.ALL;
USE ieee.std_logic_UNSIGNED.ALL;

ENTITY TestGenerator IS
	PORT(CLK: IN STD_LOGIC:='0'; 
	A,B: OUT STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000"; 
	Correct: OUT STD_LOGIC_VECTOR(8 DOWNTO 0):="000000000");
END TestGenerator;

ARCHITECTURE generator OF TestGenerator IS 
SIGNAL AA,BB: STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";	 
BEGIN 		
	A<=AA;
	B<=BB;
	-- The Process Below shows how to implement the system using behavioural logic
	PROCESS (AA,BB)  
	VARIABLE X: STD_LOGIC_VECTOR(8 DOWNTO 0):="000000000";
	BEGIN 
			X(4 DOWNTO 0) := ('0'&AA(3 DOWNTO 0)) + ('0'&BB(3 DOWNTO 0));	
			if(X(4 DOWNTO 0) > "01001") then
				X(3 DOWNTO 0) := X(3 DOWNTO 0)+"0110";
				X(4) := '1';
			end if;
			X(8 DOWNTO 4) := ("0000"&X(4)) + ('0'&AA(7 DOWNTO 4)) + ('0'&BB(7 DOWNTO 4));
			if(X(8 DOWNTO 4) > "01001") then
				X(7 DOWNTO 4) := X(7 DOWNTO 4)+"0110";
				X(8) := '1';
			end if;		
			CORRECT<=X;
	END	PROCESS;
	-- The Process below changes the values of AA and BB(=> A and B) when the clock has a rising edge
	-- (A = 0, B = 0) => (99, 99)
	PROCESS 										
	BEGIN						
		FOR i IN 0 TO 9 LOOP
			FOR j IN 0 TO 9 LOOP 
				FOR K IN 0 TO 9 LOOP 
					FOR L IN 0 TO 9 LOOP 			
							AA(7 DOWNTO 4) <= CONV_STD_LOGIC_VECTOR(i,4);
							AA(3 DOWNTO 0) <= CONV_STD_LOGIC_VECTOR(j,4);
							BB(7 DOWNTO 4) <= CONV_STD_LOGIC_VECTOR(K,4);
							BB(3 DOWNTO 0) <= CONV_STD_LOGIC_VECTOR(L,4); 
							WAIT UNTIL rising_edge(CLK);  					  
					END LOOP;
				END LOOP;
			END LOOP; 
		END LOOP;
		WAIT;		
	END PROCESS;	
END;   
--------------------------------------------------
----------------- Result Analyser ----------------
--------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_ARITH.ALL;  

ENTITY ResultAnalyser IS
	PORT(CLK: IN STD_LOGIC:='0'; 					   
	Correct,myResult: IN STD_LOGIC_VECTOR(8 DOWNTO 0):="000000000");
END ResultAnalyser;

ARCHITECTURE analyser OF ResultAnalyser IS
BEGIN 
	-- The Process below make sure that the resulting output from our system equals to the correct one
	--				otherwise, print an error when the outputs are not equal to each other
	PROCESS
	BEGIN		 
		assert (myResult = Correct)
		report "The results that were obtained don't agree with the theoretical results" 
		severity ERROR;
		WAIT UNTIL rising_edge(CLK);
	END PROCESS;
END;  
--------------------------------------------------
--------------- Built In Self Test ---------------
--------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_ARITH.ALL;  

ENTITY BIST IS
END BIST;

------------------------------------------------
--------- Test For The Ripple System -----------
ARCHITECTURE ripple OF BIST IS
SIGNAL CLK: STD_LOGIC:='0';	
SIGNAL A,B: STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000"; 
SIGNAL Correct,myResult: STD_LOGIC_VECTOR(8 DOWNTO 0):="000000000";
BEGIN 
	-- 85*2 = 170 ns is the minimum delay we should have to have a correct output
	CLK <= NOT CLK AFTER 85 NS;
	G1: ENTITY WORK.TestGenerator(generator) PORT MAP(CLK, A, B, Correct); 
	G2: ENTITY WORK.System(ripple) PORT MAP(A, B, myResult(7 DOWNTO 0), myResult(8)); 
	G3: ENTITY WORK.ResultAnalyser(analyser) PORT MAP(CLK, Correct, myResult); 		
END;																	  

------------------------------------------------
----- Test For The Carry Lookahead System ------
ARCHITECTURE lookahead OF BIST IS
SIGNAL CLK: STD_LOGIC:='0';	
SIGNAL A,B: STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000"; 
SIGNAL Correct,myResult: STD_LOGIC_VECTOR(8 DOWNTO 0):="000000000";
BEGIN 					   
	-- 68*2 = 136 ns is the minimum delay we should have to have a correct output
	CLK <= NOT CLK AFTER 68 NS;
	G1: ENTITY WORK.TestGenerator(generator) PORT MAP(CLK, A, B, Correct); 
	G2: ENTITY WORK.System(lookahead) PORT MAP(A, B, myResult(7 DOWNTO 0), myResult(8)); 
	G3: ENTITY WORK.ResultAnalyser(analyser) PORT MAP(CLK, Correct, myResult); 	
END;