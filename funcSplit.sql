SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[func_Split]
	(
	@DelimitedString varchar(8000),-- String Parameter
	@Delimiter varchar(100) -- Delimiter to split string on
	)
RETURNS @tblArray TABLE
	(
	ElementID int IDENTITY(1,1), -- Array index
	Element varchar(1000) -- Array element contents
	)
AS
BEGIN

	--Local Variable Declaration
	---------------------------------

	DECLARE @index smallint,
			@Start smallint,
			@DelSize smallint

	SET @DelSize = LEN(@Delimiter)

	-- Loop through source string and add elements to destination table array
	--------------------------------------
	WHILE LEN(@DelimitedString)>0
	BEGIN
	
		SET @index =CHARINDEX(@Delimiter,@DelimitedString)
		If @index = 0
			BEGIN
				INSERT INTO
					@tblArray
					(Element)
				VALUES
					(LTRIM(RTRIM(@DelimitedString)))
				BREAK
			END
		ELSE
			BEGIN
				INSERT INTO
					@tblArray
					(Element)
				VALUES
					(LTRIM(RTRIM(SUBSTRING(@DelimitedString,1,@index-1))))
				SET @Start = @Index+@DelSize
				SET @DelimitedString = SUBSTRING(@DelimitedString, @Start, LEN(@DelimitedString)-@Start+1)
			END
	END
	RETURN
END
