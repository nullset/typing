
<type>
  <div>
    <div class="text">{ opts.text }</div>
    <div class="text">
      <span each={letter, i in output} class="letter">{letter}</span><span class="cursor blink" style="display: inline-block; background: cyan;">&nbsp;</span>
    </div>
  </div>

  <!-- this script tag is optional -->
  <script>
    var self = this;
    this.output = [];

    // {
    //   string:
    //   status:
    //   issue:
    // }

    this.test = {
      text: "A little goose walked across the road, sharing his meal with a fox."
    }
    this.test = opts.text.split('');

    this.addCharacter = function(e) {
      var character = String.fromCharCode(e.keyCode);
      this.output.push(character);
      this.update();
    }

    this.testCharacter = function(character, i) {

    }

    document.addEventListener('keydown', function(e) {
      if (e.which === 8) { // backspace
        e.preventDefault();
        self.output.splice(-1);
        self.update();
      } else {
        return e;  // Pass event to next event listener
      }
    })
    document.addEventListener('keypress', this.addCharacter.bind(this));

  </script>

</type>
