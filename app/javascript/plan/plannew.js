var sliderSelector = '.swiper-container',
    isMove = false,
    options = {
      init: false,
      loop: true,
      speed:800,
      autoplay:{
        delay:3000
      },
      effect: 'cube', 
      cubeEffect: {
        shadow: true,
        slideShadows: true,
        shadowOffset: 40,
        shadowScale: 0.94,
      },
      grabCursor: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev'
      },
      
      on: {
        init: function(){
          this.autoplay.stop();
        },
        imagesReady: function(){
          this.el.classList.remove('loading');
          this.autoplay.start();
        },
        touchMove: function(event){
          if (!isMove) {
            this.el.classList.remove('scale-in');
            this.el.classList.add('scale-out');
            isMove = true;
          }
        },
        touchEnd: function(event){
          this.el.classList.remove('scale-out');
          this.el.classList.add('scale-in');
          setTimeout(function(){
            isMove = false;
          }, 300);
        },
        slideChangeTransitionStart: function(){
          console.log('slideChangeTransitionStart '+this.activeIndex);
          if (!isMove) {
            this.el.classList.remove('scale-in');
            this.el.classList.add('scale-out');
          }
        },
        slideChangeTransitionEnd: function(){
          console.log('slideChangeTransitionEnd '+this.activeIndex);
          if (!isMove) {
            this.el.classList.remove('scale-out');
            this.el.classList.add('scale-in');
          }
        },
        transitionStart: function(){
          console.log('transitionStart '+this.activeIndex);
        },
        transitionEnd: function(){
          console.log('transitionEnd '+this.activeIndex);
        },
        slideChange:function(){
          console.log('slideChange '+this.activeIndex);
          console.log(this);
        }
      }
    },
    mySwiper = new Swiper(sliderSelector, options);

mySwiper.init();
window.onload = function() {
  let client_w = document.getElementById('submit-wrap').clientWidth;
  let client_h = document.getElementById('submit-wrap').clientHeight;
  let submit = document.getElementById('submit');
  submit.style.display = "inline-block";
  submit.style.width = `${client_w}px`;
  submit.style.height = `${client_h}px`;
};