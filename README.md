# Analyser - Markdown Parser

_Analyser [analize] - to analyze something_

Analyser includes ```MarkDownParserCore``` and ```BlockRenderer``` modules. ```MarkDownParserCore``` handles only a small and specific subset of the markdown format. If you need a proper markdown spec support you should check Commonmark. 

```MarkDownParserCore``` provides  ```[Block]``` type output and ```BlockRenderer``` transforms the blocks into ```NSAttributedStrings``` and HTML strings.

This package is developed for Camping Finland iOS app.  
