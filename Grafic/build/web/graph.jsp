<%-- 
    Document   : graph
    Created on : 21.04.2017, 15:32:06
    Author     : Юля
--%>

<%@page import="graph_package.Graph"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Графіки математичних функцій</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <script>
              <%
      double a = Double.parseDouble( request.getParameter("first"));
        double b = Double.parseDouble( request.getParameter("second"));
        int N = Integer.parseInt( request.getParameter("number_of_points"));
        int k = Integer.parseInt( request.getParameter("function"));
        Graph g = new Graph(a, b, N, k);
        g.Tab();
%>
            function select(){
                var dd = document.getElementById('function');
                    var opts = dd.options.length;
                    var val = <%= k%>;
                    for (var i=0; i<opts; i++){
                        if (dd.options[i].value == val){
                            dd.options[i].selected = true;
                            break;
                        }
                    }
            }
            window.onload = function()
            {
                select();
  
                var n = <%= g.getN()%>;
                var x = new Array(n);
                var y = new Array(n);
                <% for(int i = 0; i < N; i++){%>
                x[<%= i %>]= <%= g.get_X(i)%>;
                y[<%= i %>]= <%= g.get_Y(i)%>;  
                <% } %>
                var canvas = document.getElementById("canvas1");
                var ctx = canvas.getContext("2d");
                var Mx = document.getElementById("canvas1").width;
                var My = document.getElementById("canvas1").height;
                        //var L = 70;
                var minX = x[0];
                var maxX = x[n-1];
                var minY = y[0];
                var maxY = y[0];
                   var w=new Array(n);
                   var line;    
                   var w0=0;
            for(var i = 0; i < n; i++)
                {
              line=String(y[i].toFixed(2));
               w[i]=ctx.measureText(line).width;
                        
                 if(minY > y[i]) minY = y[i];
                   if(maxY < y[i])maxY = y[i];                
                 if (w[i]>w0) w0=w[i];
                 
                }
                
                    L=Math.round(2*w0);
                   //alert ('w0='+String(w0)+' '+'L='+String (L));
                   
                  
                var Kx = (Mx - 2 * L)/(maxX - minX);
                var Ky = (My - 2 * L)/(minY - maxY);
                
                var Zx = (Mx * minX - L * (minX + maxX))/(minX - maxX);
                var Zy = (My * maxY - L * (minY + maxY))/(maxY - minY);
              
            
                 //ctx.moveTo(L,Math.round(Ky*gy+Zy));
                 //ctx.lineTo(Math.round(Mx-L), Math.round(Ky*gy+Zy));
                 //ctx.stroke();
             
                ctx.fillStyle="green";
              for(var i = 0; i < n; i++)
              {
                  ctx.fillRect(Kx * x[i] + Zx, Ky * y[i] + Zy, 2, 2);
              }
              
              var gx, gy;
              if (minX*maxX<=0) gx=0;
              if (minX*maxX>0) gx=minX;
              if ((minX*maxX>0) && (minX<0))   gx=maxX;
              
               if (minY*maxY<=0) gy=0;
              if ((minY*maxY>0) && (minY>0)) gy=minY;
              if ((minY*maxY>0) && (minY<0))   gy=maxY;
              ctx.beginPath();
                 ctx.strokeStyle="red";
                    ctx.lineWidth="5";
                    ctx.moveTo(L,Math.round(Ky*gy+Zy));
                  ctx.lineTo(Mx-L, Math.round(Ky*gy+Zy));
                       ctx.moveTo(Math.round(Kx*gx+Zx),L);
                  ctx.lineTo(Math.round(Kx*gx+Zx), My-L);
               ctx.stroke();
                ctx.beginPath();
                                <%--
                    ctx.moveTo(L,My/2);
                  ctx.lineTo(Mx-L, My/2);
                    ctx.moveTo(Mx/2,L);
                  ctx.lineTo(Mx/2, My-L);
                ctx.stroke();
                --%>
                        //побудова сітки і оцифровка
             krokX=Math.floor((Mx-2*L)/10);
             krokY= Math.floor((My-2*L)/10);
               var xx=minX;
               var yy=minY;
               var dx=(maxX-minX)/10;
               var dy=(maxY-minY)/10;
    ctx.strokeStyle="green";
     ctx.lineWidth="1";
     ctx.font="14pt Arial";

  
                 
    for(var i = 0; i < 11; i++)
              {
             
                //  горизонтальні лінії   
                 ctx.moveTo(L,L+i*krokY);
                  ctx.lineTo(Mx-L,L+i*krokY);
                    
                   ctx.fillText (String(yy.toFixed(2)),0, My-L-i*krokY);
                  //вертикальні
                      ctx.moveTo(L+i*krokX,L);
                  ctx.lineTo(L+i*krokX, My-L);
                  ctx.fillText (String(xx.toFixed(2)),L-20+i*krokX, My-L+15);
                   ctx.stroke();
                    xx=xx + dx;
                    yy=yy + dy; 
              }
               //підписи
             
                
           
            };
               
        </script>
    </head>
    <body>
	<header>
		<h1>Графіки математичних функцій</h1>
	</header>
	<div id="first_settings" class="settings">
		<h4>Загальні налаштування</h4>
		<form id="form1" action="NewServlet" method="POST" >
			<div class="row">
				<label>Введіть межі:</label>
				<input type="text" name="first" value=<%=request.getParameter("first")%> >
				<input type="text" name="second" value=<%=request.getParameter("second")%> >
			</div>
			<br>
			<div class="row">
				<label>Введіть кількість точок:</label>
				<input type="text" name="number_of_points" value=<%=request.getParameter("number_of_points")%> >
			</div>
			<br>
			<div class="row">
				<label>Виберіть функцію:</label>
				<select name="function" id="function" >
                                    <option value = "0">y = x^2 - 4</option>
                                    <option value = "1">y = x^3 - 27</option>
                                    <option value = "2">y = sin(x)</option>
                                    <option value = "3">y = cos(x)</option>
                                    <option value = "4">y = tg(x)</option>
				</select>
			</div>
			<br>
                        <input type="submit" value="Побудувати" />
		</form>
	</div>

	<div id="second_settings" class="settings">
		<h4>Додаткові налаштування</h4>
                <form id="form2" action="NewServlet" method="POST">
			<div class="row">
				<label>Тип:</label>
				<select>
					<option selected>Точки круглі</option>
					<option>Точки прямокутні</option>
					<option>З'єднані точки</option>
				</select>
			</div>
			<br>
			<div class="row">
				<label>Колір:</label>
				<input type="color">
			</div>
			<br>
			<div class="row">
				<label>Товщина:</label>
				<input type="number" min="1" max="10">
			</div>
			<br>
			<div class="row">
				<label>Анімація:</label>
				<input type="checkbox" value="1">
			</div>
		</form>
	</div>

	<div id="graph">
		<h2>Графік функції</h2>
                <div id="graphic">
                    <canvas id="canvas1" width="1400" height="700" >
                                
                    </canvas>
                </div>
	</div>

	<footer>
		<p>2017 &copy; Julia Korniychuk</p>
	</footer>
    </body>
</html>
