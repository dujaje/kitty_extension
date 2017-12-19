import swal from 'sweetalert2/dist/sweetalert2.all.min.js'

function myFunction() {
  console.log("You're in helloWorldSwal")
  const button = document.querySelector("#hello-js")
  button.addEventListener("click", () => {
    swal('Hello world!')
  })
}

export { myFunction };
