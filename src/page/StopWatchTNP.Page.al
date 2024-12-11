page 50108 "Stop WatchTNP"
{
    ApplicationArea = All;
    Caption = 'Stop Watch';
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = StopWatchTNP;


    layout
    {
        area(Content)
        {
            group(General)
            {


                // field(EntryID; Rec.EntryID)
                // {
                //     Visible = false;
                // }
                field("Start Time"; Rec."Start Time")
                {

                    //DataClassification = ToBeClassified;
                }

                field("End Time"; Rec."End Time")
                {

                }

                field("Elapsed Time"; Rec."Elapsed Time")
                {

                }

                // part()

            }

            part("Lap History"; "Lap Sub PageTNP")
            {
                //SubPageLink = "Lap No."= field(EntryID);
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TimeStart)
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Start Time';
                ApplicationArea = all;
                Image = Start;

                // Start StopWatch Timer
                trigger OnAction()
                begin

                    if not hasStarted then begin
                        hasStarted := true;
                        StartTime := CurrentDateTime;
                        if not Rec.get(Rec.EntryID) then begin
                            Rec.Validate("Start Time", StartTime);
                            Rec.Validate("End Time", 0DT);
                            Rec.Validate("Elapsed Time", '');
                            Rec.Insert(true);
                            LapCounter := 0;
                        end else begin
                            //Rec.Reset();
                            Rec.Validate("Start Time", StartTime);
                            Rec.Validate("End Time", 0DT);
                            Rec.Validate("Elapsed Time", '');
                            Rec.Modify(true);

                        end;


                    end

                end;
            }

            // Stops StopWatch Timer
            action(TimeStop)
            {
                Caption = 'Stop Time';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Stop;
                Enabled = hasStarted;
                ApplicationArea = all;
                trigger OnAction()
                var
                begin
                    hasStarted := false;
                    EndTime := CurrentDateTime;
                    TimePassed := EndTime - StartTime;
                    Rec.Validate("End Time", EndTime);
                    Rec.Validate("Elapsed Time", Format(TimePassed));
                    Rec.Modify(true);
                end;

            }

            // Set Lap Time
            action(NewLap)
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Caption = 'New Lap';
                Enabled = hasStarted;
                Image = Timesheet;
                trigger OnAction()
                var
                    LapRec: Record LapTNP;
                begin
                    EndTime := CurrentDateTime;
                    TimePassed := EndTime - StartTime;
                    LapCounter += 1;
                    LapRec.Init();
                    LapRec.Validate("Lap No.", LapCounter);
                    LapRec.Validate(Time, Format(TimePassed));
                    LapRec.Insert(true);
                    StartTime := CurrentDateTime;

                end;
            }
        }

    }

    trigger OnOpenPage()
    var
        LapTNP: Record LapTNP;
    begin
        LapTNP.Reset();
        if LapTNP.FindSet() then
            repeat
                //Clear(LapTNP);
                LapTNP.Delete();
            until LapTNP.Next() = 0;

        //LapTNP.Modify(true);
        Clear(Rec);
        Rec.Modify(true);

    end;

    var
        hasStarted: Boolean;
        TimePassed: duration;
        StartTime, EndTime : datetime;
        StopWatchTNP: Record StopWatchTNP;
        LapCounter: Integer;
}
