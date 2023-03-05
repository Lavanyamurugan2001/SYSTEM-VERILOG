//--------------------------------------------------------------------------------------------
//Bounded mailbox:
//
//A bounded mailbox is with the size defined. Mailbox becomes full when on storing a 
//bounded number of messages.
//
//--------------------------------------------------------------------------------------------
class A;

  int a;
  int i;
  mailbox m;

  function new(mailbox m1);
    this.m = m1;
  endfunction

  task tra_data();
    for(i =0;i<3;i++)begin:BEGIN_MAIN

      if(m.num()==2)begin:BEGIN_1
        $display("mailbox is full");
    
      end:BEGIN_1

    else
      begin:BEGIN_2

        a++;
        m.put(a);
        $display("[%0t] 1. Transmitter: value of a = %0d",$time,a);

      end:BEGIN_2

    end:BEGIN_MAIN

  endtask
    
endclass:A


// Receiver
class B;
 
  int a;
  int i;
  mailbox m;
        
  function new(mailbox m2);
    this.m = m2;
  endfunction
                
  task rec_data();

    begin:BEGIN_MAIN

      m.get(a);
      $display("[%0t] 2. Receiver: value of a = %0d",$time,a);

    end:BEGIN_MAIN

  endtask

endclass:B

                                     
module tb();
                                            
  A a1;
  B b1;
  mailbox mb = new(2);  
                                             
  initial begin:BEGIN_MAIN

    a1 = new(mb);  
    b1 = new(mb);                                                              
    repeat(3)

    begin:BEGIN_1

      a1.tra_data();
      $display("...............................................");
      b1.rec_data();

    end:BEGIN_1

  end:BEGIN_MAIN

endmodule:tb  
