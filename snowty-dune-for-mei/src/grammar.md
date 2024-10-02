
&nbsp;&nbsp;&nbsp;&nbsp;*prgm* **::=** *defns* *main* 

&nbsp;&nbsp;&nbsp;&nbsp;*defn* **::=** *func* **|** *hdlr*   

&nbsp;&nbsp;&nbsp;&nbsp;*func* **::=**
`fun` *name*`(`*param*`,`...`) =` *expn*  

&nbsp;&nbsp;&nbsp;&nbsp;*hdlr* **::=** 
`han <` *chan* `,`**...** `>` *name*`(`*param*`,`*...*`) {`*stmt*`}`  
&nbsp;&nbsp;&nbsp;&nbsp;*main* **::=** `han <cin, cout> main` *prms* `{`*stmt*`}`  

&nbsp;&nbsp;&nbsp;&nbsp;*stmt* **::=**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
`let` *name* `:=` *expn*`;` *stmt*    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp;
`when` *expn* `do {`*stmt*`} otherwse {`*stmt*`}`     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`send` *expn* `=>` *name* `;` *stmt*    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`receive` *name* `:` *type* `<=` *expn* `;` *stmt*    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp;
`select` *name* `:` *type* `<=` *expn* `;` *stmt*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp;
`handle` *expn* `of |` *label* `=> {`*stmt*`}` *...*   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`open` *name* `<=>` *name* `;` *stmt*   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`link` *name* `<=>` *name* `;` *stmt*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`start <` *name*`,`*...*`>` *name* `(`*expn*`,`*...*`)` `;` *stmt*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`now <` *name*`,`*...*`>` *name* `(`*expn*`,`*...*`)` `;`       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp;
`close` *name*`;` *stmt*    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp;
`await` *name*`;` *stmt*    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|** &nbsp; 
`stop;`  
  
&nbsp;&nbsp;&nbsp;&nbsp;*expn* **::=**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
*name*   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
`42` **|** *...*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
`true` **|** `false`    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
`"Hello, world!"` **|** *...*     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `<=` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `=` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `+` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `-` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `*` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `andalso` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
*expn* `orelse` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
`not` *expn*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **|**
`if` *expn* `then` *expn* `else` *expn*  

    