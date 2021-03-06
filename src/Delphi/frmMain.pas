// Copyright (c) 2016, Jordi Corbilla
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
// - Neither the name of this library nor the names of its contributors may be
// used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

unit frmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Ani,
  Generics.collections, lib.nodes, FMX.Layouts, FMX.ExtCtrls, frmOptions;

type
  TForm2 = class(TForm)
    Button1: TButton;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label1: TLabel;
    Label2: TLabel;
    AniIndicator1: TAniIndicator;
    RoundRect1: TRoundRect;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RoundRect2: TRoundRect;
    Label8: TLabel;
    RoundRect3: TRoundRect;
    Label9: TLabel;
    RoundRect4: TRoundRect;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    ImageViewer1: TImageViewer;
    BitmapAnimation1: TBitmapAnimation;
    RESTClient1: TRESTClient;
    ImageViewer2: TImageViewer;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure ThreadTerminated(Sender : TObject);
  public
    listNodes : TList<TNode>;
  end;

var
  Form2: TForm2;

implementation

uses
  System.JSON, lib.animation;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm2.Button1Click(Sender: TObject);
var
  nodeThread : TNodeThread;
begin
  nodeThread := TNodeThread.Create(RESTRequest1, RESTResponse1, listNodes, AniIndicator1);
  nodeThread.OnTerminate := ThreadTerminated;
  nodeThread.Start;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form3.ShowModal();
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  listNodes := TList<TNode>.create();
  listNodes.Add(TNode.Create('status/picontroller', 4286578432, 4292613180, Label2, RoundRect1));
  listNodes.Add(TNode.Create('status/pi01', 4286578432, 4292613180, Label7, RoundRect2));
  listNodes.Add(TNode.Create('status/pi02', 4286578432, 4292613180, Label8, RoundRect3));
  listNodes.Add(TNode.Create('status/pi03', 4286578432, 4292613180, Label9, RoundRect4));
  RoundRect1.Fill.Color := 4292613180;
  RoundRect2.Fill.Color := 4292613180;
  RoundRect3.Fill.Color := 4292613180;
  RoundRect4.Fill.Color := 4292613180;
  Label6.Text := 'Status RPi 3 Grid:';
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  listNodes.free;
end;

procedure TForm2.ThreadTerminated(Sender: TObject);
begin
  AniIndicator1.Visible := false;
  AniIndicator1.Enabled := false;
end;

end.
