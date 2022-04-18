


;LCD control:
;Example code from Arduino:
;  const int colorR = 255;
;  const int colorG = 0;
;  const int colorB = 0;
;
;DFRobot_LCD lcd(16,2);  //16 characters and 2 lines of show
;
;void setup() {
;    // initialize
;    lcd.init();
;    
;    lcd.setRGB(colorR, colorG, colorB);//If the module is a monochrome screen, you need to shield it
;    
;    // Print a message to the LCD.
;    lcd.print("hello, world!");
;
;    delay(1000);
;}
;
;void loop() {
;    // set the cursor to column 0, line 1
;    // (note: line 1 is the second row, since counting begins with 0):
;    lcd.setCursor(0, 1);
;    // print the number of seconds since reset:
;
;------------
;/*******************************public*******************************/
;DFRobot_LCD::DFRobot_LCD(uint8_t lcd_cols,uint8_t lcd_rows,uint8_t lcd_Addr,uint8_t RGB_Addr)
;{
;  _lcdAddr = lcd_Addr;
;  _RGBAddr = RGB_Addr;
;  _cols = lcd_cols;
;  _rows = lcd_rows;
;}
;
;void DFRobot_LCD::init()
;{
;	Wire.begin();
;	_showfunction = LCD_4BITMODE | LCD_1LINE | LCD_5x8DOTS;
;	begin(_cols, _rows);
;}
;
;void DFRobot_LCD::clear()
;{
;    command(LCD_CLEARDISPLAY);        // clear display, set cursor position to zero
;    delayMicroseconds(2000);          // this command takes a long time!
;}
;
;void DFRobot_LCD::home()
;{
;    command(LCD_RETURNHOME);        // set cursor position to zero
;    delayMicroseconds(2000);        // this command takes a long time!
;}
;
;/*!
; *  @brief Device I2C Arress
; */
;#define LCD_ADDRESS     (0x7c>>1)
;#define RGB_ADDRESS     (0xc0>>1)
;
;
; DFRobot_LCD(uint8_t lcd_cols,uint8_t lcd_rows,uint8_t lcd_Addr=LCD_ADDRESS,uint8_t RGB_Addr=RGB_ADDRESS);
; 
; 
; inline void DFRobot_LCD::command(uint8_t value)
;{
;    uint8_t data[3] = {0x80, value};
;    send(data, 2);
;}
;
;/*!
; *  @brief flags for function set
; */
;#define LCD_8BITMODE 0x10
;#define LCD_4BITMODE 0x00
;#define LCD_2LINE 0x08
;#define LCD_1LINE 0x00
;#define LCD_5x10DOTS 0x04
;#define LCD_5x8DOTS 0x00
;
;/*******************************private*******************************/
;void DFRobot_LCD::begin(uint8_t cols, uint8_t lines, uint8_t dotsize) 
;{
;    if (lines > 1) {
;        _showfunction |= LCD_2LINE;
;    }
;    _numlines = lines;
;    _currline = 0;
;
;    ///< for some 1 line displays you can select a 10 pixel high font
;    if ((dotsize != 0) && (lines == 1)) {
;        _showfunction |= LCD_5x10DOTS;
;    }
;
;    ///< SEE PAGE 45/46 FOR INITIALIZATION SPECIFICATION!
;    ///< according to datasheet, we need at least 40ms after power rises above 2.7V
;    ///< before sending commands. Arduino can turn on way befer 4.5V so we'll wait 50
;    delay(50);
;
;
;    ///< this is according to the hitachi HD44780 datasheet
;    ///< page 45 figure 23
;
;    ///< Send function set command sequence
;    command(LCD_FUNCTIONSET | _showfunction);
;    delay(5);  // wait more than 4.1ms
;	
;	///< second try
;    command(LCD_FUNCTIONSET | _showfunction);
;    delay(5);
;
;    ///< third go
;    command(LCD_FUNCTIONSET | _showfunction);
;
;
;
;
;    ///< turn the display on with no cursor or blinking default
;    _showcontrol = LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF;
;    display();
;
;    ///< clear it off
;    clear();
;
;    ///< Initialize to default text direction (for romance languages)
;    _showmode = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
;    ///< set the entry mode
;    command(LCD_ENTRYMODESET | _showmode);
;    
;    
;    ///< backlight init
;    setReg(REG_MODE1, 0);
;    ///< set LEDs controllable by both PWM and GRPPWM registers
;    setReg(REG_OUTPUT, 0xFF);
;    ///< set MODE2 values
;    ///< 0010 0000 -> 0x20  (DMBLNK to 1, ie blinky mode)
;    setReg(REG_MODE2, 0x20);
;    
;    setColorWhite();
;
;}
;
;void DFRobot_LCD::send(uint8_t *data, uint8_t len)
;{
;    Wire.beginTransmission(_lcdAddr);        // transmit to device #4
;    for(int i=0; i<len; i++) {
;        Wire.write(data[i]);
;		delay(5);
;    }
;    Wire.endTransmission();                     // stop transmitting
;}
;
;void DFRobot_LCD::setReg(uint8_t addr, uint8_t data)
;{
;    Wire.beginTransmission(_RGBAddr); // transmit to device #4
;    Wire.write(addr);
;    Wire.write(data);
;    Wire.endTransmission();    // stop transmitting
;}


' addr:byte, data:byte
LCD_setReg:
  i2c
	


