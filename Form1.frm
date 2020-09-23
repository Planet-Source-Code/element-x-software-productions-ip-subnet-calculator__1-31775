VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form Form1 
   Caption         =   "Class C IP Subnet Calculator"
   ClientHeight    =   4635
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8310
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4635
   ScaleWidth      =   8310
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ListView ListView1 
      Height          =   3375
      Left            =   0
      TabIndex        =   12
      Top             =   1200
      Width           =   8295
      _ExtentX        =   14631
      _ExtentY        =   5953
      View            =   3
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   3
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Network Address"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "Host Address Range"
         Object.Width           =   6174
      EndProperty
      BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   2
         Text            =   "Broadcast Address"
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   1440
      MaxLength       =   3
      TabIndex        =   3
      Top             =   360
      Width           =   495
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   960
      MaxLength       =   3
      TabIndex        =   2
      Top             =   360
      Width           =   495
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   480
      MaxLength       =   3
      TabIndex        =   1
      Top             =   360
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Calculate"
      Height          =   375
      Left            =   3480
      TabIndex        =   7
      Top             =   240
      Width           =   975
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2160
      TabIndex        =   6
      Top             =   360
      Width           =   615
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   0
      MaxLength       =   3
      TabIndex        =   0
      Top             =   360
      Width           =   495
   End
   Begin VB.Label lblNetwork 
      Height          =   255
      Left            =   6480
      TabIndex        =   14
      Top             =   840
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "Network Number:"
      Height          =   255
      Left            =   5040
      TabIndex        =   13
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label lblUseable 
      Height          =   255
      Left            =   4560
      TabIndex        =   11
      Top             =   840
      Width           =   375
   End
   Begin VB.Label Label4 
      Caption         =   "Useable Host's Per Subnet:"
      Height          =   255
      Left            =   2520
      TabIndex        =   10
      Top             =   840
      Width           =   2055
   End
   Begin VB.Label lblSN 
      Height          =   255
      Left            =   1080
      TabIndex        =   9
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "Subnet Mask:"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   840
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Bits Borrowed:"
      Height          =   255
      Left            =   2160
      TabIndex        =   5
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "IP Address:"
      Height          =   255
      Left            =   0
      TabIndex        =   4
      Top             =   120
      Width           =   975
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim BBP As Integer
Dim StepUp As Integer

If Text1.Text >= 0 And Text1.Text <= 127 Then GoTo ClassA
If Text1.Text >= 128 And Text1.Text <= 191 Then GoTo ClassB
If Text1.Text >= 192 And Text1.Text <= 223 Then GoTo ClassC

ClassC:
Dim IPWOLastOctet As String

If Text2.Text = "" Then
MsgBox "You have to enter the number of bits borrowed!", vbExclamation, "No Bits Borrowed"
Exit Sub
End If

IPWOLastOctet = Text1.Text & "." & Text4.Text & "." & Text5.Text & "."

ListView1.ListItems.Clear

BBP = 2 ^ Text2.Text

lblUseable = BBP - 2

Select Case BBP
Case Is = 2
lblSN.Caption = "255.255.255.254"
Case Is = 4
lblSN.Caption = "255.255.255.252"
Case Is = 8
lblSN.Caption = "255.255.255.248"
Case Is = 16
lblSN.Caption = "255.255.255.240"
Case Is = 32
lblSN.Caption = "255.255.255.224"
Case Is = 64
lblSN.Caption = "255.255.255.192"
Case Is = 128
lblSN.Caption = "255.255.255.128"
Case Else
MsgBox "For Class C addresses you can only borrow between 2 and 7 bits to create useable subnets!", vbExclamation, "Error In Bits"
End Select

StepUp = 256 / BBP

z = 1

For x = 0 To 256 - StepUp Step StepUp
ListView1.ListItems.Add z, , IPWOLastOctet & x
ListView1.ListItems(z).ListSubItems.Add , , IPWOLastOctet & x + 1 & "  -  " & IPWOLastOctet & x + 2
ListView1.ListItems(z).ListSubItems.Add , , IPWOLastOctet & ((x + StepUp) - 1)
z = z + 1
If x > 256 Then Exit Sub
Next
lblNetwork.Caption = ListView1.ListItems.Item(1).Text
ListView1.ListItems.Remove 1
ListView1.ListItems.Remove ListView1.ListItems.Count

Exit Sub

ClassB:
MsgBox "IP Address Entered is a Class B address"

ClassA:
MsgBox "Ip Address Entered is a Class A address"
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 46 Then Text4.SetFocus

position = 0
position = InStr(position + 1, Text1.Text, ".", vbBinaryCompare)
If position > 0 Then
Text1.SelStart = position - 1
Text1.SelLength = 1
Text1.SelText = ""
End If
End Sub

Private Sub Text4_KeyPress(KeyAscii As Integer)
If KeyAscii = 46 Then Text5.SetFocus

position = 0
position = InStr(position + 1, Text4.Text, ".", vbBinaryCompare)
If position > 0 Then
Text4.SelStart = position - 1
Text4.SelLength = 1
Text4.SelText = ""
End If
End Sub

Private Sub Text5_KeyPress(KeyAscii As Integer)
If KeyAscii = 46 Then Text6.SetFocus

position = 0
position = InStr(position + 1, Text5.Text, ".", vbBinaryCompare)
If position > 0 Then
Text5.SelStart = position - 1
Text5.SelLength = 1
Text5.SelText = ""
End If
End Sub

Private Sub Text6_KeyPress(KeyAscii As Integer)
position = 0
position = InStr(position + 1, Text6.Text, ".", vbBinaryCompare)
If position > 0 Then
Text6.SelStart = position - 1
Text6.SelLength = 1
Text6.SelText = ""
End If
End Sub
