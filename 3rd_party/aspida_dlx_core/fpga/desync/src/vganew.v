/*
*				 VGA Controller
*			  Pavlos		Mattheakis
*				  January 2004
*/

module vga(datain,Whichpattern,addressout,patternbit,redout,greenout,blueout,hsyncout,vsyncout,clkout,reset,clkin);
input [7:0] datain;
input Whichpattern;
input reset, clkin, clkout;
output [14:0] addressout,patternbit;//
output [1:0] redout;//
output [2:0] greenout,blueout;//
output    hsyncout,vsyncout;
   

reg [14:0] addressout;//
reg [1:0] redout;//
reg [2:0] greenout,blueout;//
reg hsyncout,vsyncout;

reg helpme;
reg [2:0] helpcounter;
reg [4:0] testing;

reg [15:0] Vbase;//
reg [9:0] vcounter;//
reg [15:0] hcounter;//
reg [10:0] hgate;//
reg [9:0] vgate;//
//reg clkout;//
reg [2:0] clockcounter;//
reg [9:0] pixelsfromhsyncout;
reg [9:0] rowsfromvsyncout;

reg videoon,bporch,fporch,vbporch,vfporch;//

reg [8:0] gridhcounter,gridvcounter;//
reg [2:0] patterncounter,patternrow;


reg [14:0] patternbit;
reg pattern;


always @(posedge clkin)
begin
	if(reset == 1)
	begin
		Vbase = 16'h0;
	end
end

always @(posedge clkin)
begin
	if(reset == 1)
	begin
		testing = 0;
	end
	else
	begin
		testing = testing + 1;
	end
end

/*	
*	o Helpcounter eine enas metritis o opios mas voithaei na
*	ftiaksoume alo ena reset to opoio tha arxikopiisei ta 
*	simata pou alazoun times me tous palmous tou pixel clock.
*	(clkout).Arxika o helpcounter ginete 1 me to reset tou
*	protou rologiou ala epeita ton afksanoume mexri na parei
*	tin timi 7 opote kanoume to helpme 0.Apo to 1 mexri to
*	7 to helpme(reset pou theloume na ftiaksoume) eine sto
*	1(6 * posedge clkin = 6 * 20ns = 120ns) xronos arketos
*	gia na prolaboume ke na arxikopiisoume ta simata. 
*/ 

always @(posedge clkin)
begin
	if(reset == 1)
	begin
		helpcounter = 3'h0;
		helpme = 1;
	end
	else if(clockcounter == 1 && helpcounter < 6)
		helpcounter = helpcounter + 1;
	else
	begin
		helpme = 0;
		helpcounter = 7;
	end
end

/*
*	Edo pernoume to roloi pou mas dinei i FPGA ke to opoio
*	exei periodo 20ns(50Mhz) ke ftiaxnoume ena diko mas roloi 
*	sta 40ns(25 Mhz).
*/


always @(posedge clkin)
begin
	if(reset == 1)
	begin
		clockcounter = 3'h0;
//		clkout = 1'h0;
	end
	else
	begin
		if(clockcounter == 0)
		begin
			clockcounter = clockcounter + 1;
//			clkout = 0;
		end
		else
		begin
			clockcounter = 0;
//			clkout = 1;
		end
	end
end

/*
*	ANALYSH:640(PIXELS) x 480(LINES)
*/

always @(posedge clkin)
begin
	if(reset == 1)
	begin
		hgate = 804;
		vgate = 523;
	end
end

/* 
*	O VGA controller bgazei 8bit RGB xroma:2-red,3-green,
*	3-blue.
*/

always @(datain)
begin
	if(reset == 1)
	begin
		redout = 2'h0;
		greenout = 3'h0;
		blueout = 3'h0;
	end
	else if(videoon == 0)

	begin

		redout = 0;

		greenout = 0;

		blueout = 0;

	end

	else	if(videoon == 1)
	begin
		redout = datain[1:0];
		greenout = datain[4:2];
		blueout = datain[7:5];
		/*redout = {2{datain}};
		greenout = {3{datain}};
		blueout = {3{datain}};*/
	end
end

always @(clkout)
begin
	//if(videoon == 1)
	//		addressout = ( Vbase + vcounter*hgate + hcounter + testing )% 256;
	
	/*ASPIDA DEMO 160x120*/
			addressout = Vbase + (gridvcounter*160) + gridhcounter;
	
			if(pattern == 0)
			begin
				patternbit = 0 + patternrow*4 + patterncounter;
			end
			if(pattern == 1)
			begin
				patternbit = 16 + patternrow*4 + patterncounter;
			end 
	/*
	Test:landscape square and 5x5 pixel square...
	 */
	/*if((videoon==1)&&((hcounter >= 677 && hcounter <=687) || (hcounter >=47 && hcounter <= 57) || (vcounter >=33 && vcounter <= 43) || (vcounter >= 503) && (vcounter <=513)))
		addressout = 190;
	else if((videoon==1)&&(hcounter >= 300 && hcounter <=303 && vcounter >= 100 && vcounter <=103))
		addressout = 130;
	else
		addressout = 0;	*/
		

end


	
always @(posedge clkout)
begin
	if(helpme == 1)
	begin
		hcounter = 11'h0;
	end
	else if(hcounter == 804)
	begin
		hcounter = 0;
	end
	else
	begin 
		hcounter = hcounter + 1;
	end
end

always @(posedge clkout)
begin
	if(helpme == 1)
	begin
		vcounter = 11'h0;
	end
	else if(vcounter == 526)
	begin
		vcounter = 0;
	end
	else	if(hcounter == 690 && vcounter < 526)
	begin 
		vcounter = vcounter + 1;
	end
end


always @(posedge clkout)
begin
	if(helpme == 1)
	begin
		videoon = 0;
	end
	else if(hcounter > 47 && hcounter < 687  && vcounter > 33 && vcounter <513 )
	begin
		videoon = 1;
	end
	else
		videoon = 0;
end


always @(posedge clkout)
begin
	if(helpme == 1)
	begin
		hsyncout = 1;
	end
	else if(hcounter > 710 && hcounter < 804)
	begin
		hsyncout = 0;
	end
	else 
		hsyncout = 1;
end

always @(posedge clkout)
begin
	if(helpme == 1)
	begin
		vsyncout = 1;
	end
	else if(vcounter > 523 )
	begin
		vsyncout = 0;
	end
	else
	begin
		vsyncout = 1;
	end
end
	
always @(posedge clkout)
begin
	if(reset == 1)
	begin
		gridhcounter = 0;
	end
	else if( hcounter >= 48 && (hcounter%4 == 3))
	begin
		gridhcounter = gridhcounter + 1;
	end
	else if(hcounter==0)
		gridhcounter = 0;
end

always @(posedge clkout)
begin
	if(reset == 1)
	begin
		gridvcounter = 0;
     end
	else if( patternrow == 0 && hcounter == 45 && vcounter < 35)
	begin
		gridvcounter = 0;
	end
	else if(patternrow == 0 && hcounter == 45)
		gridvcounter = gridvcounter + 1;
end

always 
begin
patterncounter = hcounter[1:0];
patternrow = (vcounter[1:0]+2)%4;
pattern = Whichpattern;
end
/*always
begin
	if(gridhcounter==5 && gridvcounter[0] == 1)
	pattern = 0;
	else
	pattern = 1;
end*/

endmodule
		
