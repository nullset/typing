
<type>
  <div>
    <div class="text">{ opts.text }</div>
    <div class="text">
      <span each={output} class="letter"><span class="{this.status}">{this.string}</span></span><span class="cursor blink">&nbsp;</span>
    </div>
  </div>

  <div class="type-results {is-hidden: !this.test.isComplete}">
    <div class="wpm">{wpm} words per minute</div>
    <div class="accuracy">{accuracy}% accurate</div>

  <!-- this script tag is optional -->
  <script>
    var self = this;
    this.output = [];
    this.wpm = null;
    this.accuracy = null;
    this.incorrectKeys = [];

    // TODO
    // * handle spaces

    this.test = {
      text: opts.text,
      array: opts.text.split(''),
      isStarted: null,
      isComplete: null
    }

    this.addCharacter = function(e) {
      var character = String.fromCharCode(e.keyCode);
      var compareCharacter = this.testCharacter(character, this.output.length);
      if (e.keyCode === 32) {
        character = ' ';  // Change a space to a non-breaking space
      }
      this.output.push(_.merge({string: character}, compareCharacter));
      this.update();
    }

    this.testCharacter = function(character, i) {
      if (this.test.array[i] !== character) {
        this.incorrectKeys.push(1);
        return {status: 'bad'}
      } else {
        return;
      }
    }

    this.calculateWpm = function() {
      var words = this.output.length/5;
      var uncorrectedErrors = _.filter(this.output, {status: 'bad'}).length/5;
      var minutes = (this.test.isComplete - this.test.isStarted) / 1000 / 60;
      this.wpm = ((words - uncorrectedErrors)/minutes).toFixed(1);
    }

    this.calculateAccuracy = function() {
      this.accuracy = ((1 - (this.incorrectKeys.length/this.test.array.length)) * 100).toFixed(2);
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
    // document.addEventListener('keypress', this.addCharacter.bind(this));

    document.addEventListener('keypress', function(e) {
      if (!self.test.isStarted) {
        self.test.isStarted = (new Date()).getTime();
      }
      if (!self.test.isComplete) {
        if (self.output.length < self.test.array.length) {
          self.addCharacter(e);
        }
        if (self.output.length === self.test.array.length) {
          self.test.isComplete = (new Date()).getTime();
          self.calculateWpm();
          self.calculateAccuracy();
          self.update();
          alert('test finished')
        }
      }

    });

  </script>

</type>
