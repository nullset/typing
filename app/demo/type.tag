
<type>
  <div>
    <div class="text">{ opts.text }</div>
    <div class="text">
      <span each={output} class="letter"><span class="{this.status}">{this.string}</span></span><span class="cursor blink" style="display: inline-block; background: cyan;">&nbsp;</span>
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

    // TODO
    // * handle spaces

    this.test = {
      text: "A little goose walked across the road, sharing his meal with a fox.",
      isComplete: false
    }
    this.test.array = opts.text.split('');

    this.addCharacter = function(e) {
      if (this.output.length < this.test.array.length) {
        var character = String.fromCharCode(e.keyCode);
        var compareCharacter = this.testCharacter(character, this.output.length);
        this.output.push(_.merge({string: character}, compareCharacter));
        this.update();
      } else {
        this.test.isComplete = true;
        alert('test finished')
      }
    }

    this.testCharacter = function(character, i) {
      if (this.test.array[i] !== character) {
        return {status: 'bad'}
      } else {
        return;
      }
    }

    document.addEventListener('keydown', function(e) {
      if (e.which === 8) { // backspace
        e.preventDefault();
        if (self.output.length > 0) {
          self.output.splice(-1);
          self.update();
        }
      } else {
        return e;  // Pass event to next event listener
      }
    })
    document.addEventListener('keypress', this.addCharacter.bind(this));

  </script>

</type>
