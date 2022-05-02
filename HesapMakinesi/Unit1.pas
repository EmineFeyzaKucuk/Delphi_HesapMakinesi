unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TAciklama = class
  public
    Aciklama1: string;
  end;

  THesap = class
  public
    sayi1: integer;
    sayi2: integer;
    islemtipi: string;
  end;
  TIslem = class
  public
    Function islemyap(islem: THesap): integer;
  end;

  TForm1 = class(TForm)
    Edit1: TEdit;
    btn7: TButton;
    btn6: TButton;
    btn5: TButton;
    btn4: TButton;
    btnCarpi: TButton;
    btnBolum: TButton;
    btn9: TButton;
    btn8: TButton;
    btn3: TButton;
    btn2: TButton;
    btn1: TButton;
    btnArt�: TButton;
    btnesittir: TButton;
    btn0: TButton;
    btneksi: TButton;
    btnCE: TButton;
    btnC: TButton;
    Label1: TLabel;
    procedure btn0Click(Sender: TObject);
    function islemm(sayilar: THesap): integer;
    procedure btnArt�Click(Sender: TObject);
    procedure btnesittirClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    sayilar: THesap;
    Aciklama: TAciklama;
    // tekrar: integer;
    end;

  var
    Form1: TForm1;

implementation

{$R *.fmx}

Function TIslem.islemyap(islem: THesap): integer;
begin
  if islem.islemtipi = '+' then // e�er i�lem + ise;
  begin
    result := islem.sayi1 + islem.sayi2;
    // x + y   topla ve function sonucu yap
  end
  else if islem.islemtipi = '-' then
  begin
    result := islem.sayi1 - islem.sayi2; // x - y   "       "
  end
  else if islem.islemtipi = '*' then
  begin
    result := islem.sayi1 * islem.sayi2; // x * y    "     "
  end
  else if islem.islemtipi = '/' then
  begin
    result := trunc(islem.sayi1 / islem.sayi2);
    // "   "  B�lme i�lemi sonucundaki tam say�y� almam�z� sa�lar
  end;

end;

function TForm1.islemm(sayilar: THesap): integer;
var
  islemmm: TIslem;
begin
  islemmm := TIslem.Create;
  Edit1.Text := ''; // edit1'i bo�alt
  result := islemmm.islemyap(sayilar);

end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  // E�er Klavyede '' i�indekilerden ba�ka bir de�er giriliyorsa
  if not(KeyChar in ['0' .. '9', '.', #8]) then
  begin
    KeyChar := #0; // Bo� kal�r bir de�er gelmez
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  sayilar := THesap.Create;
  Aciklama := TAciklama.Create;
end;

procedure TForm1.btnesittirClick(Sender: TObject);
var
  x: integer;
  y: integer;
begin
  x := sayilar.sayi1; // Say�1'i x'e atad�k

  sayilar.sayi2 := strtointdef(Edit1.Text, 0); // edit1'deki 2. de�eri ald�k
  y := sayilar.sayi2; // 2.de�erimizi y'ye atad�k
  if (sayilar.islemtipi = '+') then // i�lem + ise
  begin
    Edit1.Text := inttostr(islemm(sayilar));
    // fonksiyona de�erler g�nderilir ve gelen sonu� edite yazd�r�l�r.
  end
  else if (sayilar.islemtipi = '-') then
  begin
    Edit1.Text := inttostr(islemm(sayilar)) // "      "
  end
  else if (sayilar.islemtipi = '*') then
  begin
    Edit1.Text := inttostr(islemm(sayilar))

  end
  else if (sayilar.islemtipi = '/') then
  begin
    Edit1.Text := inttostr(islemm(sayilar))
  end;
  Aciklama.Aciklama1 := sayilar.sayi1.ToString + sayilar.islemtipi +
    sayilar.sayi2.ToString + '=';
  Label1.Text := Aciklama.Aciklama1;
end;

procedure TForm1.btn0Click(Sender: TObject);
begin
  // B�t�n say� butonlar�n�n event� buraya ba�l� oldu�u i�in click olay�nda g�nderilen de�eri al�yoruz
  // edit1'in i�inde olan de�erin yan�na yazd�r�yruz.
  Edit1.Text := Edit1.Text + (Sender as TButton).Text;
end;

procedure TForm1.btnCClick(Sender: TObject);
begin
  // Editi bo�alt�p de�i�kenlerin de�erini s�f�rlar
  Edit1.Text := '';
  sayilar.sayi1 := 0;
  sayilar.sayi2 := 0;
end;

procedure TForm1.btnCEClick(Sender: TObject);
begin
  // Editi temizler
  Edit1.Text := '';
end;

procedure TForm1.btnArt�Click(Sender: TObject);
begin

  sayilar.sayi1 := strtointdef(Edit1.Text, 0); // Sayi1'i edit1 den al�yoruz.

  // strtointdef kullan�ld� ��nk� editten yaz� girilirse hata almay� �nlemek i�in
  Edit1.Text := ''; // 2.de�eri alabilmek i�in editi bo�altt�k
  // Butona gelen de�erleri kontrol ediyoruz
  if ((Sender as TButton).Text = '+') then
  begin
    sayilar.islemtipi := '+'
  end
  else if ((Sender as TButton).Text = '-') then
  begin
    sayilar.islemtipi := '-'
  end
  else if ((Sender as TButton).Text = '*') then
  begin
    sayilar.islemtipi := '*'
  end
  else if ((Sender as TButton).Text = '/') then
  begin
    sayilar.islemtipi := '/'
  end;

end;

end.
