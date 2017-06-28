// Universal

if (['/','/about','/category'].indexOf(window.location.pathname) >= 0){
document.querySelector("a[href='" + window.location.pathname + "']").className="active"
}

year = new Date().getFullYear()
document.querySelector("#year").innerHTML = year

// Nick
document.querySelector("#contactBtn").addEventListener("click", function(){
    document.querySelector("#contact").style.display = "block";
});
document.querySelector("#close").addEventListener("click", function(){
    document.querySelector("#contact").style.display = "none";
});

// Hans
var myIndex = 0;
carousel();

function carousel() {
    var i;
    var x = document.getElementsByClassName("linkme");
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";
    }
    myIndex++;
    if (myIndex > x.length) {myIndex = 1}
    x[myIndex-1].style.display = "inline-block";
    setTimeout(carousel, 2000);
}

// Steven

function searchProduct() {

}
