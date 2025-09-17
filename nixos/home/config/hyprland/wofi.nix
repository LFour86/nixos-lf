{ ... }:
{
  home.file.".config/wofi/style.css".text = ''
* {
    font-family: Maple Mono NF CN;
    color: #e5e9f0;
}

#window {
    background: rgba(173, 216, 230, 0.15);
    margin: auto;
    padding: 15px;
    border-radius: 12px;
    /*border: 1px solid #87CEEB;*/
    box-shadow: 
        0 6px 16px rgba(135, 206, 235, 0.2),
	inset 0 0 12px rgba(173, 216, 230, 0.3);
    max-width: 90%;
    transition: all 0.3s ease;
}

#input {
    padding: 12px;
    margin-bottom: 15px;
    border-radius: 8px;
    background: rgba(11, 97, 194, 0.7); /*可改，这个是搜索栏颜色*/
    border: 1px solid #ADD8E6; 
    color: #e5e9f0;
    font-size: 1.1em;
}

#outer-box {
    padding: 10px;
}

#img {
    margin-right: 10px;
    filter: invert(85%) sepia(30%) saturate(300%);
}

#entry {
    padding: 12px;
    border-radius: 8px;           
    margin-bottom: 8px;
    transition: 
        background 0.25s ease, 
        transform 0.2s ease; 
}

#entry:selected {
    background: linear-gradient(
        to right, 
        rgba(135, 206, 235, 0.7), 
    );
    transform: translateX(5px); 
    box-shadow: 0 4px 8px rgba(70, 130, 180, 0.4);
}

#text {
    margin: 3px 0;
    text-shadow: 0 1px 2px rgba(0, 0, 30, 0.6);
}
'';
}

