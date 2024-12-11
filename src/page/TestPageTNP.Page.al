page 50107 "TestPageTNP"
{
    ApplicationArea = All;
    Caption = 'Test Page';
    PageType = Card;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {




            // field(50108; "Start Time";
            //     Date)
            //     {
            //         DataClassification = ToBeClassified;
            // }


        }
    }


    actions
    {
        area(Processing)
        {
            action(RunCode)
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Run Code';
                ApplicationArea = all;
                RunObject = codeunit CodeSpaceTNP;
                Image = CodesList;

            }
            action("Run Example")
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Run CodeUnit Object';
                ApplicationArea = all;
                Image = Action;

                trigger OnAction()
                var
                    value1, value2, answer : integer;
                    Label: Label '%1 + %2 = %3';
                //answer: Integer;
                begin
                    value1 := 500;
                    value2 := 60;
                    answer := TestCodeunit.GlobalProcedure(value1, value2);
                    Message(Label, value1, value2, answer);


                end;
            }
            action("Run Codeunit")
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Run CodeUnit Object';
                ApplicationArea = all;
                Image = Action;

                trigger OnAction()
                var
                begin
                    //TestCodeunit.GlobalProcedure2(1000, 2300);
                    //TestCodeunit.CheckCar();
                    //TestCodeunit.InsertRecord();
                    //TestCodeunit.NewEventHistory();
                    Message('I worked!!!!!! \nStop Touching me ');
                end;
            }
        }

    }
    var
        TestCodeunit: Codeunit CodeSpaceTNP;
}
